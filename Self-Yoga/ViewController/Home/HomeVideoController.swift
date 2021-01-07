//
//  HomeVideoController.swift
//  Self-Yoga
//
//  Created by Jack on 5/1/2021.
//

import UIKit
import youtube_ios_player_helper
import FirebaseFirestore

class HomeVideoViewController: UIViewController {
    
    @IBOutlet weak var videoPlayerView: YTPlayerView!
    
    var dataController = DataController()
    var bool: String?
    var db = Firestore.firestore()
    var healthKit = HealthKit()
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        healthKit.saveSteps(stepsCountValue: Int(8), date: date) { (error) in
            print("add data")
        }
        
        dataController.fetchNestedData() { collection, videoName, video in
            switch self.bool {
            case "BeginnerCollection":
                self.db.collection("Beginners Collection/vBlOYdSZucieChF6uskr/Details").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            let video = data["video id"] as? String ?? "Empty"
                            
                            self.videoPlayerView.load(withVideoId: video)
                        }
                    }
                }
            case "MasterCollection":
                self.db.collection("Masters' Collection/5Y2K4rL8tCfu9fQj6yof/Details").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            let video = data["video id"] as? String ?? "Empty"
                            
                            self.videoPlayerView.load(withVideoId: video)
                        }
                    }
                }
            default:
                print("HomeListViewController tablView numberOfRow Error")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
