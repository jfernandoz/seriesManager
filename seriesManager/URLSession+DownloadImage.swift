//
//  URLSession+DownloadImage.swift
//  seriesManager
//
//  Created by MCS on 8/20/17.
//  Copyright © 2017 MCS. All rights reserved.
//

import Foundation

extension URLSession {
    
    static func downloadWith(urlString:String, sender: URLSessionDelegate){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: sender, delegateQueue: nil)
        let downloadTask = session.downloadTask(with: URL.init(string: urlString)!)
        downloadTask.resume()
    }
    
}
