//
//  SettingViewController.swift
//  Self-Yoga
//
//  Created by itst on 21/12/2020.
//

import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {
    
    let firebaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try firebaseAuth.signOut()

            let AutViewController = self.storyboard?.instantiateViewController(identifier: "AutVC") as? ViewController

            self.view.window?.rootViewController = AutViewController
            self.view.window?.makeKeyAndVisible()

        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
//        }
     }
}
}
