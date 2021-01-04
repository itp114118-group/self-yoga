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
        
        fetchData() { collectionName, title, subtitle, duration, tempo, description in
            let yogaSet = YogaSet(title: title, subtitle: subtitle, duration: duration, tempo: tempo, description: description)
            
            switch collectionName {
            case "Beginner Collection":
                self.beginnerDataArray.append(yogaSet)
            case "Masters' Collection":
                self.masterDataArray.append(yogaSet)
            default:
                print("DataController init Error")
            }
            
        }
        
    }

    func fetchData(completionHandler:@escaping(String, String, String, String, String, String)->()) {
        db.collection("Beginners Collection").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let collectionName = "Beginner Collection"
                    let title = data["title"] as? String ?? "Empty"
                    let subtitle = data["subtitle"] as? String ?? "Empty"
                    let duration = data["duration"] as? String ?? "Empty"
                    let tempo = data["tempo"] as? String ?? "Empty"
                    let description = data["description"] as? String ?? "Empty"
                    
                    completionHandler (collectionName, title, subtitle, duration, tempo, description)
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
                    let duration = data["duration"] as? String ?? "Empty"
                    let tempo = data["tempo"] as? String ?? "Empty"
                    let description = data["description"] as? String ?? "Empty"
    
                    completionHandler (collectionName, title, subtitle, duration, tempo, description)
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
