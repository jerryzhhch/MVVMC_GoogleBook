//
//  BookTableCell.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class BookTableCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    
    static let identifier = "BookTableCell"
    
    
    func configure(book: Book) {
        
        bookTitle.text = book.volumeInfo.title
        bookAuthor.text = book.volumeInfo.author?.joined(separator: ", ")
        
        DL.download(from: book.volumeInfo.images.thumbnail) { [unowned self] img in
            
            if let image = img {
                self.bookImage.image = image
            } else {
                print("Else: \(Thread.isMainThread)")
                DispatchQueue.main.async {
                    self.bookImage.image = #imageLiteral(resourceName: "placeholder")
                }
                
            }
        }
    } //end func
    
}
