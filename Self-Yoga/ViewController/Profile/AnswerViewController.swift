//
//  AnswerViewController.swift
//  Self-Yoga
//
//  Created by itst on 15/1/2021.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var faq : FAQ?
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let faq = faq {
            question.text = faq.question
            answer.text = faq.answer
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
}
