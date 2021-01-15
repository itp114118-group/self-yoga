//
//  ForgotpwViewController.swift
//  Self-Yoga
//
//  Created by itst on 17/12/2020.
//

import UIKit
import FirebaseAuth


class ForgotpwViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var btnreset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emailView = UIImageView()
        let imgemail = UIImage(named: "email")
        emailView.image = imgemail
        emailTF.leftView = emailView
        emailTF.leftViewMode = .always
        
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0,y: emailTF.frame.height - 2, width: emailTF.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 112/255, green: 122/255, blue: 122/255, alpha: 1).cgColor
        
        emailTF.borderStyle = .none
        emailTF.layer.addSublayer(bottomLine)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPasswordDidTapped(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTF.text!) { (error) in
            if error == nil {
                print("SENT...!")
            } else {
                print("FAILED - \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
