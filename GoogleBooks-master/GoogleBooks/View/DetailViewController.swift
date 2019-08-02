//
//  DetailViewController.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Storyboarder {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailAuthor: UILabel!
    @IBOutlet weak var detailDescription: UITextView!
    @IBOutlet weak var favButton: UIButton!
    

    var viewModel: ViewModel!
    var coreViewModel: CoreViewModel!
    var book: Book!
    
    var isCore: Bool {
        return viewModel == nil 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBook()
        setupDetail()
        
        favButton.layer.cornerRadius = 15
        
    }
    
    @IBAction func favoritesTapped(_ sender: UIButton) {
        
        core.save(book)
    }
    
    func setupBook() {
        
        switch isCore {
            
        case true:
            let bk = coreViewModel.toBook(coreViewModel.currentBook)
            book = bk
        case false:
            book = viewModel.currentBook
        }
        
        if core.isFavorite(book.id) {
            favButton.isHidden = true
        }
        
    }
    
 
    func setupDetail() {
        
        detailTitle.text = book.volumeInfo.title
        detailAuthor.text = book.volumeInfo.author?.joined(separator: ", ")
        detailDescription.text = book.volumeInfo.description
        
        DL.download(from: book.volumeInfo.images.thumbnail) { img in
            if let image = img {
                self.detailImage.image = image
            } else {
                
                DispatchQueue.main.async {
                    self.detailImage.image = #imageLiteral(resourceName: "placeholder")
                }
            }
        }
    }//end func

}
