//
//  HomeViewController.swift
//  messageViewCode
//
//  Created by Sillas Santos on 30/06/23.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var auth: Auth?
    var db: Firestore?
    var idUserLogged: String?
    var emailUserLogged: String?
    var screenContact: Bool?
    var alert: Alert?
    var screen: HomeScren?
    
    override func loadView() {
        let screen = HomeScren()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = CustomColor.appLight
        configHomeView()
        configCollectionView()
        configAlert()
    }
    
    private func configHomeView() {
        screen?.navView.delegate(delegate: self)
    }
    
    private func configCollectionView() {
        screen?.delegateCollectionView(delegate: self, dataSource: self)
    }
    
    private func configAlert() {
        alert = Alert(controller: self)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell(frame: CGRect.zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension HomeViewController: NavViewProtocol {
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            screenContact = true
        case .conversation:
            screenContact = false
        }
    }
}
