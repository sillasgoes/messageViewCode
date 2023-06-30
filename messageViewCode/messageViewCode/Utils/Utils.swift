//
//  Utils.swift
//  ViewCodeDescomplicado
//
//  Created by Sillas Santos on 23/06/23.
//

import Foundation
import UIKit

struct Utils {
    struct Email {
        static func validate(email: String?, password: String?) -> Bool {
            
            guard let email = email, let password = password else {
                return false
            }
            
            guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                  !password.trimmingCharacters(in: .whitespaces).isEmpty else {
                return false
            }
            
            guard email.contains("@") && email.contains(".") else {
                return false
            }
            
            return true
        }
    }
}
