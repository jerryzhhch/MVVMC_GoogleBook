//
//  FavoriteViewController.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, Storyboarder {

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var coordinator: MyCoordinator!
    
    let coreViewModel = CoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupFavorite()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        coreViewModel.loadCore()
    }
    
    func setupFavorite() {
        favoriteTableView.register(UINib(nibName: BookTableCell.identifier, bundle: nil), forCellReuseIdentifier: BookTableCell.identifier)
        title = "Favorites"
        favoriteTableView.tableFooterView = UIView(frame: .zero)
        coreViewModel.delegate = self
    }
    
}


//MARK: TableView

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreViewModel.coreBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableCell.identifier, for: indexPath) as! BookTableCell
        
        let coreBook = coreViewModel.coreBooks[indexPath.row]
        
        guard let book = coreViewModel.toBook(coreBook) else {
            return cell
        }
        
        cell.configure(book: book)
        
        
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let coreBook = coreViewModel.coreBooks[indexPath.row]
        coreViewModel.currentBook = coreBook
        
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        detailVC.coreViewModel = coreViewModel
//        self.navigationController?.pushViewController(detailVC, animated: true)
        coordinator = MyCoordinator(nav: self.navigationController!, coreViewModel: self.coreViewModel)
        coordinator.startFromFavorite()
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}


//MARK: CoreDelegate

extension FavoriteViewController: CoreDelegate {
    
    func update() {
        DispatchQueue.main.async {
            self.favoriteTableView.reloadData()
            print("Reloaded Favorite TableView")
        }
    }
}
