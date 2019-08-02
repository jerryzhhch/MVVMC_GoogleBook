//
//  MainCoordinator.swift
//  GoogleBooks
//
//  Created by Jerry Zhou on 8/1/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import UIKit



class MyCoordinator: Coordinator {
    private var nav: UINavigationController!
    private var viewModel: ViewModel!
    private var coreViewModel: CoreViewModel!
    
    init(nav: UINavigationController, viewModel: ViewModel) {
        self.nav = nav
        self.viewModel = viewModel
    }
    
    init(nav: UINavigationController, coreViewModel: CoreViewModel) {
        self.nav = nav
        self.coreViewModel = coreViewModel
    }
    
    
    func start() {
        let vc = DetailViewController.instantiate()
        vc.viewModel = self.viewModel
        self.nav.pushViewController(vc, animated: true)
    }
    
    func startFromFavorite(){
        let vc = DetailViewController.instantiate()
        vc.coreViewModel = self.coreViewModel
        self.nav.pushViewController(vc, animated: true)
    }
    
}
