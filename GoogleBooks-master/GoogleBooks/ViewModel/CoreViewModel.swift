//
//  CoreViewModel.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

protocol CoreDelegate: class {
    func update()
}

class CoreViewModel {
    
    weak var delegate: CoreDelegate?
    
    var coreBooks = [CoreBook]() {
        didSet {
           delegate?.update()
        }
    }
    
    var currentBook: CoreBook!
    
    
    func loadCore() {
        
        if let books = core.load() {
            coreBooks = books
            print("CoreBook Count: \(coreBooks.count)")
        }
        
    }
    
    func toBook(_ core: CoreBook) -> Book? {
        
        guard let book = Book(from: core) else {
            return nil
        }
        
        return book
    }
    
    
}
