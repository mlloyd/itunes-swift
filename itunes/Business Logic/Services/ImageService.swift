//
//  ImageService.swift
//  itunes
//
//  Created by Martin Lloyd on 22/11/2015.
//  Copyright © 2015 Martin Lloyd. All rights reserved.
//

import UIKit

typealias ImageServiceCompletionHandler = (image: UIImage, fromCache: Bool) -> Void
typealias ImageServiceErrorHandler      = (error: NSError) -> Void

let aError = NSError(domain: "", code: -1, userInfo: nil)

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
protocol ImageServiceProtocol: class {
    func fetchImage(imageURL: NSURL, completionHandler: ImageServiceCompletionHandler, errorHandler: ImageServiceErrorHandler?)
    func cancelImage(imageURL: NSURL)
    func cancelAllImages()
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class ImageService: ImageServiceProtocol {

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    var queue: NSOperationQueue {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 3
        return queue
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    var session: NSURLSession {
        return NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
    }
    
    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    var imageCache: NSCache {
        let imageCache = NSCache()
        imageCache.countLimit = 100
        return imageCache
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func fetchImage(imageURL: NSURL, completionHandler: ImageServiceCompletionHandler, errorHandler: ImageServiceErrorHandler?) {
        let imageKey = imageURL.absoluteString
        
        // Check Image Cache
        if let image = self.imageCache.objectForKey(imageKey) as? UIImage {
            completionHandler(image: image, fromCache: true);
            return
        }
        
        let imageOperation = URLSessionOperation(session: self.session, url: imageURL) { (data, response, error) in
            
            // Check for error
            if let error = error {
                dispatch_async(dispatch_get_main_queue(), { () in
                    errorHandler?(error: error);
                })
                return
            }
            
            // Check to ensure we have data
            guard let data = data
                else {
                dispatch_async(dispatch_get_main_queue(), { () in
                    errorHandler?(error: aError);
                })
                return
            }
            
            // Check image data is correct
            if let image = UIImage(data: data) {
                self.imageCache.setObject(image, forKey: imageKey)
                
                dispatch_async(dispatch_get_main_queue(), { () in
                   completionHandler(image: image, fromCache: false)
                })
            }
            else {
                dispatch_async(dispatch_get_main_queue(), { () in
                    errorHandler?(error: aError)
                })
            }
        }
        
        imageOperation.name = imageKey
        self.queue.addOperation(imageOperation)
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func cancelImage(imageURL: NSURL) {
        let imageKey = imageURL.absoluteString
        
        if let operation = self.queue.operations.filter({ $0.name == imageKey }).first {
            operation.cancel()
        }
    }

    ////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////
    func cancelAllImages() {
        self.queue.cancelAllOperations()
    }
}
