//
//  DataController.swift
//  Self-Yoga
//
//  Created by Jack on 24/12/2020.
//

import Foundation
import FirebaseFirestore

class DataController {
    
    var db = Firestore.firestore()
    
    var dataArray = [YogaSet]()
    
    init() {

        fetchData() { title, subtitle in
            print(title)
            print(subtitle)
            let yogaSet = YogaSet(title: title, subtitle: subtitle)
            self.dataArray.append(yogaSet)
        }
        
    }
    
    func fetchData(completionHandler:@escaping(String, String)->()) {
        db.collection("YogaSet").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? ""
                    let subtitle = data["subtitle"] as? String ?? ""
                    
                    let yogaSet = YogaSet(title: title, subtitle: subtitle)
                    self.dataArray.append(yogaSet)
                    completionHandler (title, subtitle)
                }
            }
        }
    }
   
    func count() -> Int {
        return dataArray.count
    }
    
    func yogaSet(at index: Int) -> YogaSet {
        return dataArray[index]
    }
    
}
