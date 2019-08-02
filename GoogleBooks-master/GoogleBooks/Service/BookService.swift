//
//  BooksService.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation


typealias BookHandler = ([Book]?) -> Void
let service = BookService.sharedInstance

final class BookService {
    
    
    static let sharedInstance = BookService()
    private init() {}
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        return URLSession(configuration: config)
    }()
    
    
    func get(search: String, completion: @escaping BookHandler) {
        
        let urlString = BookAPI.getURL(with: search)
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        
        session.dataTask(with: url) { (dat, _, err) in
            if let error = err {
                completion(nil)
                print("Bad Data: \(error.localizedDescription)")
                return
            }
            
            if let data = dat {
                
                do {
                    let bookInfo = try JSONDecoder().decode(BookInfo.self, from: data)
                    
                    completion(bookInfo.items)
                } catch {
                    
                    completion(nil)
                    print("Decoding Error: \(error.localizedDescription)")
                    return
                }
            }
            
        }.resume()
        
        
        
    } //end func
    
    
} //end class
