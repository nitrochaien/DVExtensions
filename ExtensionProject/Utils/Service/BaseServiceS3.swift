//
//  BaseServiceS3.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit
import Alamofire
import AWSS3

class BaseServiceS3: BaseServiceObjectJSON {
    func uploadFileWithAssw3(s3BucketName: String, pathUrl: NSURL, filename: String, path: String, complete: @escaping (_ response: AnyObject, _ status: Bool) -> Void) {
        let transferManager = AWSS3TransferManager.default()
        if let uploadRequest = AWSS3TransferManagerUploadRequest() {
            uploadRequest.body = pathUrl as URL
            uploadRequest.key = filename
            uploadRequest.bucket = s3BucketName
            uploadRequest.acl = .publicRead
            
            transferManager.upload(uploadRequest).continueWith { (task) -> AnyObject? in
                if let error = task.error {
                    if error._domain == AWSS3TransferManagerErrorDomain as String {
                        if let errorCode = AWSS3TransferManagerErrorType(rawValue: error._code) {
                            switch (errorCode) {
                            case .cancelled, .paused:
                                break;
                                
                            default:
                                print("upload() failed: [\(error)]")
                                break;
                            }
                        } else {
                            print("upload() failed: [\(error)]")
                        }
                    } else {
                        print("upload() failed: [\(error)]")
                    }
                    
                    complete(error as AnyObject, false)
                }
                
                if task.result != nil {
                    complete("Upload successful!" as AnyObject, true)
                }
                return nil
            }
        }
    }
}
