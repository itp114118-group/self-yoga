//
//  SettingViewController.swift
//  Self-Yoga
//
//  Created by itst on 21/12/2020.
//

import UIKit
import FirebaseAuth
import MessageUI

class SettingViewController: UIViewController {
    
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try firebaseAuth.signOut()
            
            //            let AutViewController = self.storyboard?.instantiateViewController(identifier: "AutVC") as? ViewController
            //
            //            self.view.window?.rootViewController = AutViewController
            //            self.view.window?.makeKeyAndVisible()
            
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AutVC") as UIViewController
            present(vc, animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            //        }
        }
    }
    
    @IBAction func showEmail(_ sender: Any) {
        showEmail()
    }
    
    func showEmail() {
        
        guard MFMailComposeViewController.canSendMail() else {
            // Show alert informing the user
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["l.chakkei.jack@xxx.com"])
        composer.setSubject("HELP!")
        composer.setMessageBody("I need somebody...", isHTML: false)
        
        present(composer, animated: true)
    }
    
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .saved:
            print("Saved")
        case .sent:
            print("Email Sent")
        case .failed:
            print("Failed to send")
        @unknown default:
            break
        }
        
        controller.dismiss(animated: true)
    }
}


