//
//  ResigerViewController.swift
//  Self-Yoga
//
//  Created by itst on 17/12/2020.
//

import UIKit
import Firebase
import FirebaseAuth

class ResigerViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var confirmpwTF: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let emailView = UIImageView()
        let lockView = UIImageView()
        let confirmpwView = UIImageView()
        let imgemail = UIImage(named: "email")
        let imglock = UIImage(named: "lock")
        emailView.image = imgemail
        lockView.image = imglock
        confirmpwView.image = imglock
        emailTF.leftView = emailView
        pwTF.leftView = lockView
        confirmpwTF.leftView = confirmpwView
        confirmpwTF.leftViewMode = .always
        pwTF.leftViewMode = .always
        emailTF.leftViewMode = .always
        
        
        AppDelegate.setCornerRadiusOf(targetView: emailTF, radius: 18, needToApplyBorder: false, ifYesThen: nil, borderColor: nil)
        
        AppDelegate.setCornerRadiusOf(targetView: pwTF, radius: 18, needToApplyBorder: false, ifYesThen: nil, borderColor: nil)
        
        AppDelegate.setCornerRadiusOf(targetView: confirmpwTF, radius: 18, needToApplyBorder: false, ifYesThen: nil, borderColor: nil)
        // Do any additional setup after loading the view.
    
        
    }
    
    
    func validateFields() -> String? {
        
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            pwTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confirmpwTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        if pwTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) != confirmpwTF.text?.trimmingCharacters(in: .whitespacesAndNewlines){
            
            return "Please match the password"
        }
        
        let cleanedPassword = pwTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordVaild(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }else {
            
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pw = pwTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: pw) { (result, err) in
                if err != nil {
                    self.showError("Error creating user")
                }else{
                    self.transitionToHome()
                }
                
            }
        }
    }
    
    func showError(_ message:String) {
        var dialogMessage = UIAlertController(title: "Error!", message: message , preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
        })
            
            dialogMessage.addAction(ok)
            
            self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func transitionToHome() {
        let CoverViewController = storyboard?.instantiateViewController(identifier: "CoverVC") as? CoverTabBarViewController
        
        view.window?.rootViewController = CoverViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    
}
