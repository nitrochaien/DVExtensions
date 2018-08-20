//
//  BaseDownloadFile.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension BaseServiceObjectJSON {
    // Download file
    func downLoadFile(pathFile: URL, complete: @escaping (_ response: AnyObject, _ isfinish: Bool, _ isStatus: Bool, _ progress: Float?) -> Void) {
        let destination = DownloadRequest.suggestedDownloadDestination()
        FileManager().clearTmpDirectory()
        Alamofire.download(pathFile, to: destination).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
            print("Progress: \(progress.fractionCompleted)")
            complete(progress, false, true, Float(progress.fractionCompleted))
            } .validate().responseData { ( response ) in
                if response.destinationURL != nil {
                    print(response.destinationURL!)
                    complete(response.destinationURL! as AnyObject, true, true, 0)
                } else {
                    complete(response as AnyObject, true, false, 0)
                }
        }
    }
    
    func downloadMultiFile(requests:[DataRequest]) {
        SessionManager.default.startRequestsImmediately = false
        let chain = RequestChain(requests: requests)
        chain.start { (done, error) in
            
        }
        //
        //    let firstRequest = Alamofire.request("https://httpbin.org/get")
        //    let secondRequest = Alamofire.request("https://httpbin.org/get")
        //
    }
}

class RequestChain {
    typealias CompletionHandler = (_ success: Bool, _ errorResult: ErrorResult?) -> Void
    
    struct ErrorResult {
        let request: DataRequest?
        let error: Error?
    }
    
    fileprivate var requests:[DataRequest] = []
    
    init(requests: [DataRequest]) {
        self.requests = requests
    }
    
    func start(_ completionHandler: @escaping CompletionHandler) {
        if let request = requests.first {
            request.response(completionHandler: { (response: DefaultDataResponse) in
                if let error = response.error {
                    completionHandler(false, ErrorResult(request: request, error: error))
                    return
                }
                
                self.requests.removeFirst()
                self.start(completionHandler)
            })
            request.resume()
        }else {
            completionHandler(true, nil)
            return
        }
        
    }
}
