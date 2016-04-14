//
//  ImageLoader.swift
//  Goyava
//
//  Created by Susim Samanta on 13/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class ImageLoader: NSObject {
    let cache = NSCache()
    class var sharedLoader : ImageLoader {
        struct Static {
            static let instance : ImageLoader = ImageLoader()
        }
        return Static.instance
    }
    func imageForUrl(urlString: String, completionHandler:(image: UIImage?, url: String) -> ()) {
        let downloadTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!, completionHandler: {(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if (error != nil) {
                completionHandler(image: nil, url: urlString)
                return
            }
            if let data = data {
                let image = UIImage(data: data)
                self.cache.setObject(data, forKey: urlString)
                completionHandler(image: image, url: urlString)
                return
            }
            
        })
        downloadTask.resume()
    }
}
