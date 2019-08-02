//
//  BooksAPI.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation



struct BookAPI {
    
    
    static let base = "https://www.googleapis.com/books/v1/volumes?q="
    
    
    static func getURL(with search: String) -> String {
        return base + search
    }
    
    
}
