//
//  Alert.swift
//  ViewCodeDescomplicado
//
//  Created by Sillas Santos on 27/06/23.
//

import Foundation
import UIKit

class Alert: NSObject {
    
    var controller: UIViewController?
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func getAlert(title: String, message: String, _ completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "OK", style: .default) { action in
            completion?()
        }
        alertController.addAction(cancelar)
        controller?.present(alertController, animated: true, completion: nil)
    }
}
