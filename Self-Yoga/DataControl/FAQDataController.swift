//
//  FAQDataController.swift
//  Self-Yoga
//
//  Created by itst on 15/1/2021.
//

import UIKit
import CoreData

class FAQDataController {
    var dataArray:[FAQ]
    
    init() {
        self.dataArray = [FAQ]()
        
        let question1 = FAQ(question:"How to use this app?",answer: "You should choose the pose and watch the video. Finally, you can check the correction in the pose.")
        let question2 = FAQ(question: "How to add Apple Health?",answer: "When you go the Goal Page, the app will ask you allow the Health app. If you mission the notes, you can go the setting to control.")
        let question3 = FAQ(question: "Can not join the Seesion?",answer: "you can restart the app again.")
        let question4 = FAQ(question: "I for hot my password.",answer: "you can choose forgot password button.")
        
        self.dataArray.append(question1)
        self.dataArray.append(question2)
        self.dataArray.append(question3)
        self.dataArray.append(question4)
    }
    
    func count() -> Int {
        return dataArray.count
    }
    
    func faq(at index : Int) -> FAQ {
        return dataArray[index]
    }
    
    func  add(faq : FAQ)  {
        self.dataArray.append(faq)
    }
    }

