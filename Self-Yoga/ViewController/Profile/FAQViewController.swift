//
//  FAQViewController.swift
//  Self-Yoga
//
//  Created by itst on 14/1/2021.
//

import UIKit
import CoreData

class FAQViewController: UIViewController {
    var dataController = FAQDataController()
    @IBOutlet weak var FAQTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let FAQVC = segue.destination as? AnswerViewController {
        if let indexPath = self.FAQTableView.indexPathForSelectedRow {
            let i = dataController.faq(at: indexPath.row)
            FAQVC.faq = i
        }
        }
    }
}

extension FAQViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FAQTableView.dequeueReusableCell(withIdentifier: "FAQcell")
        let f = dataController.faq(at: indexPath.row)
        cell?.textLabel?.text = "\(f.question)"
        return cell!
    }
}

