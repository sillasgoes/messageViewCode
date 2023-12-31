//
//  Extension+UIView.swift
//  messageViewCode
//
//  Created by Sillas Santos on 29/06/23.
//

import Foundation
import UIKit

extension UIView {
    
    func pin(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func edges() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: topAnchor),
            self.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

