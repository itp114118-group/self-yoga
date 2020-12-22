//
//  Utilities.swift
//  Self-Yoga
//
//  Created by itst on 21/12/2020.
//

import  Foundation
import UIKit

class Utilities {
    static func isPasswordVaild(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }

}
