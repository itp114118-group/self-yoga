//
//  SettingViewController.swift
//  Self-Yoga
//
//  Created by itst on 21/12/2020.
//

import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {
    
    @IBOutlet weak var ProfilrTableView: UITableView!
    @IBOutlet weak var btnlogout: UILabel!
    
    let firebaseAuth = Auth.auth()
    var setting = ["FAQ", "Contact Us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func logout() {
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfilrTableView.dequeueReusableCell(withIdentifier: "settingcell")
        cell?.textLabel?.text = setting[indexPath.row]
        return cell!
    }
}
