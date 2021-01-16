//
//  HomeDetailViewController.swift
//  Self-Yoga
//
//  Created by Jack on 25/12/2020.
//

import UIKit

class HomeDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var firestoreController = FirestoreController()
    var bool: String?
    var yogaTitle: String?
    var duration: String?
    var tempo: String?
    var yogaDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = yogaTitle
        durationLabel.text = duration
        tempoLabel.text = tempo
        descriptionLabel.text = yogaDescription
        
        firestoreController.fetchNestedData() { collectionName, currentPose, videoName, video in
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HomeVideoViewController {
            if segue.identifier == "showDetails" {
                controller.titles = yogaTitle
                controller.desc = yogaDescription
                switch bool {
                case "BeginnerCollection":
                    controller.bool = "BeginnerCollection"
                    controller.currentPose = "Warrior pose"
                case "MasterCollection":
                    controller.bool = "MasterCollection"
                    controller.currentPose = "Dance pose"
                default:
                    print("HomeDetailViewController prepare Error")
                }
            }
            
        }
    }
    
}

extension HomeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        
        switch bool {
        case "BeginnerCollection":
            numberOfRow = firestoreController.beginnerNestedDataArray.count
        case "MasterCollection":
            numberOfRow = firestoreController.masterNestedDataArray.count
        default:
            print("HomeDetailViewController tablView numberOfRow error")
        }
        
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        switch bool {
        case "BeginnerCollection":
            let begCollections = firestoreController.beginnerNestedDataArray[indexPath.row]
            cell.textLabel?.text = "Please Watch \(begCollections.videoName!)"
        case "MasterCollection":
            let masterCollections = firestoreController.masterNestedDataArray[indexPath.row]
            cell.textLabel?.text = "Please Watch \(masterCollections.videoName!)"
        default:
            print("HomeDetailViewController tableView show data error")
        }
        
        return cell
    }
    
}
