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
        
        fetchData() { title, subtitle in
            let yogaSet = YogaSet(title: title, subtitle: subtitle)
            self.beginnerDataArray.append(yogaSet)
            self.masterDataArray.append(yogaSet)
        }
        
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
    
                    completionHandler (title, subtitle)
                }
            }
        }
    }
    
//    func yogaSet(at index: Int) -> YogaSet {
//        return beginnerDataArray[index]
//    }
    
}
