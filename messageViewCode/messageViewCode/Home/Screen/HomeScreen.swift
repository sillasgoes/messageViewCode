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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubView() {
        
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
        ])
    }
}
