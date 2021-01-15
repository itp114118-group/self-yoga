//
//  FAQViewController.swift
//  Self-Yoga
//
//  Created by itst on 14/1/2021.
//

import UIKit

class FAQViewController: UIViewController {

    var FAQ = ["How to use this app?", "How to add Apple Health?", "Can not join the Seesion?", "I for hot my password.", "Can"]
    
    @IBOutlet weak var FAQTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FAQTableView.dataSource = self
        FAQTableView.delegate = self
    }
}

extension FAQViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FAQ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FAQTableView.dequeueReusableCell(withIdentifier: "FAQcell")
        cell?.textLabel?.text = FAQ[indexPath.row]
        return cell!
    }
}

