//
//  DownloadManager.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

typealias ImageHandler = (UIImage?) -> Void
let DL = DownloadManager.shared

final class DownloadManager {
    
    static let shared = DownloadManager()
    private init() {}
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    let cache: NSCache = NSCache<NSString, UIImage>()
    
    
    func download(from url: String, completion: @escaping ImageHandler) {
        
        if let image = cache.object(forKey: url as NSString) {
            completion(image)
            return
        }
        
        guard let finalURL = URL(string: url) else {
            completion(nil)
            return
        }
        
        session.dataTask(with: finalURL) { [unowned self] (dat, _, _) in
            
            if let data = dat {
                
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                
                self.cache.setObject(image, forKey: url as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            
        }.resume()
        
    }//end func
}
