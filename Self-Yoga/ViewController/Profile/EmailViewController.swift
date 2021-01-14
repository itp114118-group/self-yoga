//
//  EmailViewController.swift
//  Self-Yoga
//
//  Created by Jack on 14/1/2021.
//

import UIKit
import MessageUI

class EmailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        showEmail()
        // Do any additional setup after loading the view.
    }
    
    func showEmail() {
        
        guard MFMailComposeViewController.canSendMail() else {
            // Show alert informing the user
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["support@seanallen.co"])
        composer.setSubject("HELP")
        composer.setMessageBody("I need help!", isHTML: false)
        
        present(composer, animated: true)
    }
    
}

extension EmailViewController: MFMailComposeViewControllerDelegate {
    
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
