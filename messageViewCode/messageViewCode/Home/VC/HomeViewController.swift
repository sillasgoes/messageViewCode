//
//  HomeViewController.swift
//  messageViewCode
//
//  Created by Sillas Santos on 30/06/23.
//

import UIKit

class HomeViewController: UIViewController {

    var screen: HomeScren?
    
    override func loadView() {
        let screen = HomeScren()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension HomeViewController: HomeScreenProtocol {
    
}
