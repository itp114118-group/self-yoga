//
//  LoginViewController.swift
//  Self-Yoga
//
//  Created by itst on 13/12/2020.
//

// account: admin@gmail.com    Password: 12345678
// pod install -> GoogleSignIn and Chart, if fail

import UIKit
import SwiftUI
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var btnlogin: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let emailView = UIImageView()
        let lockView = UIImageView()
        let imgemail = UIImage(named: "email")
        let imglock = UIImage(named: "lock")
        emailView.image = imgemail
        lockView.image = imglock
        emailTF.leftView = emailView
        pwTF.leftView = lockView
        pwTF.leftViewMode = .always
        emailTF.leftViewMode = .always
        
        
        AppDelegate.setCornerRadiusOf(targetView: emailTF, radius: 18, needToApplyBorder: false, ifYesThen: nil, borderColor: nil)
        
        AppDelegate.setCornerRadiusOf(targetView: pwTF, radius: 18, needToApplyBorder: false, ifYesThen: nil, borderColor: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let  pw = pwTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: pw) { (result, error) in
            if error != nil{
                
                var dialogMessage = UIAlertController(title: "Error!", message: error!.localizedDescription , preferredStyle: .alert)
                
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                     print("Ok button tapped")
                })
                    
                    dialogMessage.addAction(ok)
                    
                    self.present(dialogMessage, animated: true, completion: nil)
                
            }else{
            let CoverViewController = self.storyboard?.instantiateViewController(identifier: "CoverVC") as? CoverTabBarViewController
            
            self.view.window?.rootViewController = CoverViewController
            self.view.window?.makeKeyAndVisible()
            
            }
        }
    }
}
