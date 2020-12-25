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
    
    var beginnerDataArray = [YogaSet]()
    var masterDataArray = [YogaSet]()
    
    init() {
        
    }
    
    func fetchData(completionHandler:@escaping(String, String)->()) {
        db.collection("Beginners Collection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? "Empty"
                    let subtitle = data["subtitle"] as? String ?? "Empty"
                    
                    let yogaSet = YogaSet(title: title, subtitle: subtitle)
                    self.beginnerDataArray.append(yogaSet)
                    
                    completionHandler (title, subtitle)
                }
            }
        }
        
        db.collection("Masters' Collection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? "Empty"
                    let subtitle = data["subtitle"] as? String ?? "Empty"
                    
                    let yogaSet = YogaSet(title: title, subtitle: subtitle)
                    self.masterDataArray.append(yogaSet)
                    
                    completionHandler (title, subtitle)
                }
            }
        }
    }
    
//    func yogaSet(at index: Int) -> YogaSet {
//        return beginnerDataArray[index]
//    }
    
}
