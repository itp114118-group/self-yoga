//
//  FAQViewController.swift
//  Self-Yoga
//
//  Created by itst on 14/1/2021.
//

import UIKit

class FAQViewController: UIViewController, UITableViewDelegate {
        
    @IBOutlet weak var FAQTableView: UITableView!
    
    var faqDataController = FAQDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FAQTableView.dataSource = self
        FAQTableView.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let FAQVC = segue.destination as? AnswerViewController {
            if segue.identifier == "AnsSeque" {
                if let indexPath = self.FAQTableView.indexPathForSelectedRow {
                    let i = faqDataController.faq(at: indexPath.row)
                    FAQVC.faq = i
                }
            }
        }
    }
}

extension FAQViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqDataController.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FAQTableView.dequeueReusableCell(withIdentifier: "FAQcell", for: indexPath)
        let f = faqDataController.faq(at: indexPath.row)
        cell.textLabel?.text = "\(f.question)"
        return cell
    }
}

