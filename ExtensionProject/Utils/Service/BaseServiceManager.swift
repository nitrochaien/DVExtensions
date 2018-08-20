//
//  BaseServiceManager.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit
import Alamofire

struct Headers {
    static let Content_Type = "Content-Type"
    static let Accept = "Accept"
    static let Authorization = "Authorization"
    static let Application_json = "application/json"
    static let Application_form_urlencoded = "application/x-www-form-urlencoded"
    static let Application_form_data = "application/form-data"
    static let TextHtml = "text/html"
}

enum FileType {
    case Image
    case Link
}

struct UploadFile {
    // type image or link
    var fileType: FileType
    
    var fileName: String?
    var withName: String?
    var mimeType: String?
    var scale: Float?
    
    //local file to upload
    var pathFile: String?
    // type image to upload
    var image: UIImage?
    
    //full URL upload
    var url: NSURL?
}

class BaseServiceManager: NSObject {
    var sessionManager: Alamofire.SessionManager!
    var baseURL: String = ""
    var headers: HTTPHeaders = [:]
    var timeOut = 120
    
    override init() {
        super.init()
        sessionConfiguration()
    }
    
    // init with base url
    func initWith(baseURL:String) -> BaseServiceManager {
        self.baseURL = baseURL
        sessionConfiguration()
        return self
    }
    
    func sessionConfiguration() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(timeOut)
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    // MARK:- update headerIfNeed
    func updateHeaderIfNeed(key: String, value: String) -> Void {
        print("\(key):\(value)")
        headers.updateValue(value, forKey: key)
    }
    
    func baseURLAppend(path:String) -> String {
        let fullPath = baseURL + path
        print("-----> fullPath: " + fullPath)
        return fullPath
    }
    
    // MARK: Action get, post, delete, upload
    // Model mapping is nil -> return response data type
    func request<T>(type: T.Type?, method: HTTPMethod, params: [String : Any], pathURL: String, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        sessionManager.request(baseURLAppend(path: pathURL), method: method, parameters: params, encoding: URLEncoding.default, headers: headers).responseData { (dataResponse) in
            self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                if status == false {
                    complete(data, status, code)
                    return
                }
                if let type = type {
                    // parser data to json.
                    self.paserJsonFromData(type: type, from: data as! Data, complete: { (responseJson) in
                        complete(responseJson, status, code)
                    })
                } else {
                    // model mapping is nil -> return response data
                    complete(data, status, code)
                    return
                }
            })
        }
    }
    
    func request<T>(type: T.Type?, method: HTTPMethod, params: [String : Any], pathURL: String, attachData: [UploadFile], uploadProgress: @escaping (_ progress: Progress) -> Void, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        
        sessionManager.upload(multipartFormData: { multipartFormData in
            for attachFile in attachData {
                if attachFile.fileType == .Image {
                    guard let image = attachFile.image else {return}
                    if let imageData = UIImageJPEGRepresentation(image, CGFloat(attachFile.scale ?? 1)) {
                        multipartFormData.append(imageData, withName: attachFile.withName ?? "", fileName: attachFile.fileName ?? "" , mimeType: attachFile.mimeType ?? "")
                    }
                } else {
                    guard let pathFile = attachFile.pathFile else {return}
                    do {
                        let imageData = try Data(contentsOf: pathFile.asURL())
                        multipartFormData.append(imageData, withName: attachFile.withName ?? "", fileName: attachFile.fileName ?? "" , mimeType: attachFile.mimeType ?? "")
                    } catch {
                        print ("loading image file error")
                    }
                }
            }
            
            for (key, value) in params {
                let stringValue = "\(value)"
                if stringValue.isEmpty { return }
                
                if let data = stringValue.data(using: String.Encoding.utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: baseURLAppend(path: pathURL), method: method, headers: headers, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    uploadProgress(progress)
                })
                upload.responseData(completionHandler: { (dataResponse) in
                    self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                        if status == false {
                            complete(data, status, code)
                            return
                        }
                        // model mapping is nil -> return response data
                        if type == nil {
                            complete(data, status, code)
                            return
                        }
                        // parser data to json.
                        self.paserJsonFromData(type: type!, from: data as! Data, complete: { (responseJson) in
                            complete(responseJson, status, code)
                        })
                    })
                })
            case .failure(let encodingError):
                print("error:\(encodingError)")
                complete(encodingResult as AnyObject, false, nil)
            }
        })
    }
    
    func uploadFile<T>(type: T.Type?, uploadFile: UploadFile, complete: @escaping (_ response: AnyObject, _ status: Bool,_ code: Int?) -> Void) where T: Decodable {
        // Use Alamofire to upload the image
        guard let url = uploadFile.url else { return }
        guard let pathFile = uploadFile.pathFile else { return }
        
        let imageToUploadURL = URL.init(fileURLWithPath: pathFile)
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageToUploadURL, withName: uploadFile.withName ?? "")
        },to: url.absoluteString!,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("uploading...")
                    print(progress.completedUnitCount)
                })
                upload.responseData(completionHandler: { (dataResponse) in
                    self.handleResponse(dataResponse: dataResponse, complete: { (data, status, code) in
                        if status == false {
                            complete(data, status, code)
                            return
                        }
                        // model mapping is nil -> return response data
                        if type == nil {
                            complete(data, status, code)
                            return
                        }
                        // parser data to json.
                        self.paserJsonFromData(type: type!, from: data as! Data, complete: { (responseJson) in
                            complete(responseJson, status, code)
                        })
                    })
                })
            case .failure(let encodingError):
                print(encodingError)
                complete(encodingError.localizedDescription as AnyObject, false, nil)
            }
        })
    }
}

extension BaseServiceManager {
    func paserJsonFromData<T>(type: T.Type, from data: Data, complete:@escaping (_ response:AnyObject)->Void) where T: Decodable {
        let decoder = JSONDecoder()
        do {
            let parsedData = try decoder.decode(type, from: data)
            complete(parsedData as AnyObject)
        } catch {
            print(error)
            complete(error.localizedDescription as AnyObject)
        }
    }
    
    func handleResponse(dataResponse:DataResponse<Data>, complete:@escaping (_ response:AnyObject, _ status:Bool, _ statusCode: Int?)->Void) {
        switch(dataResponse.result) {
        case .success(_):
            if let value = dataResponse.result.value {
                complete(value as AnyObject, true, dataResponse.response?.statusCode)
            }
            break
        case .failure(_):
            print(dataResponse.result.error!)
            complete(dataResponse.result.error! as AnyObject, false, dataResponse.response?.statusCode)
            break
        }
    }
}
