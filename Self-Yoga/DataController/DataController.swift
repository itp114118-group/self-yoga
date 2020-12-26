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
        
        fetchData() { title, subtitle, collectionName in
            let yogaSet = YogaSet(title: title, subtitle: subtitle)
            
            switch collectionName {
            case "Beginner Collection":
                self.beginnerDataArray.append(yogaSet)
            case "Masters' Collection":
                self.masterDataArray.append(yogaSet)
            default:
                print("Error")
            }
            
        }
        
    }
    
    func fetchData(completionHandler:@escaping(String, String, String)->()) {
        db.collection("Beginners Collection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let collectionName = "Beginner Collection"
                    let title = data["title"] as? String ?? "Empty"
                    let subtitle = data["subtitle"] as? String ?? "Empty"
                    
                    completionHandler (title, subtitle, collectionName)
                }
            }
        }
        
        db.collection("Masters' Collection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    let collectionName = "Masters' Collection"
                    let title = data["title"] as? String ?? "Empty"
                    let subtitle = data["subtitle"] as? String ?? "Empty"
    
                    completionHandler (title, subtitle, collectionName)
                }
            }
        }
    }
    
    func beginnerCollectionIndex(at index: Int) -> YogaSet {
        return beginnerDataArray[index]
    }
    
    func masterCollectionIndex(at index: Int) -> YogaSet {
        return masterDataArray[index]
    }
    
}
