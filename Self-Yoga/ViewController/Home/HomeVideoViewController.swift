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
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lbldocu: UILabel!
    @IBOutlet weak var btnPose: UIButton!
    
    var firestoreController = FirestoreController()
    var bool: String?
    var db = Firestore.firestore()
    var titles : String?
    var desc : String?
    var currentPose: String?
    
    var healthKitController = HealthKitController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbltitle.text = titles
        lbldocu.text = desc
        print("Current Pose: \(currentPose)")
        
        // Me don't know how to use child()
        firestoreController.fetchNestedData() { collection, currentPose, videoName, video in
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
                print("HomeVideoViewController error")
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navVC = segue.destination as? UINavigationController
        let tableVC = navVC?.viewControllers.first as! HomePoseViewController
        tableVC.currentPose = currentPose
        
    }
    
    
}
