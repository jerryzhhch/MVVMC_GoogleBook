//
//  Book.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

struct BookInfo: Decodable {
    let items: [Book]
}


class Book: Decodable {
    
    let id: String
    let volumeInfo: VolumeInfo
    
    var isFav: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id
        case volumeInfo
    }
    
    init?(from core: CoreBook) {
        
        guard let uid = core.uid, let title = core.title, let descrip = core.descrip, let author = core.author, let image = core.url else {
            return nil
        }
        let volumeInfo = VolumeInfo(title: title, description: descrip, author: [author], images: ImageLinks(thumbnail: image))
        
        self.id = uid
        self.volumeInfo = volumeInfo
        
    }
    
}


struct VolumeInfo: Decodable {
    
    let title: String
    let description: String?
    let author: [String]?
    let images: ImageLinks
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case author = "authors"
        case images = "imageLinks"
    }
    
    init(title: String, description: String, author: [String]?, images: ImageLinks) {
        
        self.title = title
        self.description = description
        self.author = author
        self.images = images
    }
    
    
}

struct ImageLinks: Decodable {
    let thumbnail: String
}
