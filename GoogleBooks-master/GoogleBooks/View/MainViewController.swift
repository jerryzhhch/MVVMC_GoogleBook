//
//  ViewController.swift
//  GoogleBooks
//
//  Created by mac on 5/20/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Storyboarder {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var coordinator: MyCoordinator?
    
    let viewModel = ViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        createSearch()
    }
    
    //MARK: Search Functionality
    func createSearch() {
        
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search book titles.."
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    //MARK: Setup
    func setup() {
        mainTableView.register(UINib(nibName: BookTableCell.identifier, bundle: nil), forCellReuseIdentifier: BookTableCell.identifier)
        definesPresentationContext = true
        mainTableView.tableFooterView = UIView(frame: .zero)
        viewModel.delegate = self
        
    }
    
    


}

//MARK: TableView

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableCell.identifier, for: indexPath) as! BookTableCell
        
        let book = viewModel.books[indexPath.row]
        cell.configure(book: book)
        
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let book = viewModel.books[indexPath.row]
        viewModel.currentBook = book
        
        self.coordinator = MyCoordinator(nav: self.navigationController!, viewModel: self.viewModel)
        self.coordinator?.start()
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        detailVC.viewModel = viewModel
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

//MARK: SearchBar Delegate

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchQuery = searchBar.text,
            let search = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        viewModel.getBooks(with: search)
    }
}

//MARK: ViewModelDelegate

extension MainViewController: ViewDelegate {
    
    func update() {
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
            print("Reloaded Main TableView")
        }
    }
}
