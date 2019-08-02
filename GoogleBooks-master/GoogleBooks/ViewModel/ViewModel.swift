//
//  ViewModel.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

protocol ViewDelegate: class {
    func update()
}

class ViewModel {
    
    weak var delegate: ViewDelegate?
    
    var books = [Book]() {
        didSet {
            delegate?.update()
        }
    }
    
    
    var currentBook: Book!
    
    func getBooks(with search: String) {
        
        service.get(search: search) { [unowned self] bk in
            if let bks = bk {
                self.books = bks
                print("Book Count: \(self.books.count)")
            }
        }
    }
    
    
}
