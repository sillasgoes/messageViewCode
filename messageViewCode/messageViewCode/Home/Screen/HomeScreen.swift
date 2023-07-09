//
//  HomeScren.swift
//  messageViewCode
//
//  Created by Sillas Santos on 30/06/23.
//

import UIKit

protocol HomeScreenProtocol {
    
}

class HomeScren: UIView {
    
    lazy var navView: NavView = {
        let view = NavView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.delaysContentTouches = false
        cv.register(MessageLastCollectionViewCell.self, forCellWithReuseIdentifier: MessageLastCollectionViewCell.identifier)
        cv.register(MessageDetailCollectionViewCellCollectionViewCell.self, forCellWithReuseIdentifier: MessageDetailCollectionViewCellCollectionViewCell.identifier)
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        cv.setCollectionViewLayout(layout, animated: false)
        return cv
    }()
    
    func delegateCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubView() {
        addSubview(navView)
        addSubview(collectionView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            navView.topAnchor.constraint(equalTo: topAnchor),
            navView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navView.heightAnchor.constraint(equalToConstant: 140),
            
            collectionView.topAnchor.constraint(equalTo: navView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
