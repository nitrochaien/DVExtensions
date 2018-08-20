//
//  FileManager+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import Foundation

extension FileManager {
    func clearTmpDirectory() {
        do {
            var tmpDirURL:URL
            if #available(iOS 10.0, *) {
                tmpDirURL = FileManager.default.temporaryDirectory
            } else {
                // Fallback on earlier versions
                tmpDirURL = URL(string:  NSTemporaryDirectory() as String)!
            }
            let tmpDirectory = try contentsOfDirectory(atPath: tmpDirURL.path)
            try tmpDirectory.forEach { file in
                let fileUrl = tmpDirURL.appendingPathComponent(file)
                try removeItem(atPath: fileUrl.path)
            }
        } catch {
            //catch the error somehow
        }
    }
}
