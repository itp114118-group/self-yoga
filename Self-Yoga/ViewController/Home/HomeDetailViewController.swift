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
    
    var dataController = DataController()
    var bool: String?
    var yogaTitle: String?
    var duration: String?
    var tempo: String?
    var yogaDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(bool)
        titleLabel.text = yogaTitle
        durationLabel.text = duration
        tempoLabel.text = tempo
        descriptionLabel.text = yogaDescription
        
        dataController.fetchNestedData() { collectionName, videoName, video in
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? HomeVideoViewController {
            if segue.identifier == "showDetails" {
                    switch bool {
                    case "BeginnerCollection":
                        controller.bool = "BeginnerCollection"
                    case "MasterCollection":
                        controller.bool = "MasterCollection"
                    default:
                        print("HomeListViewController prepare Error")
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
            numberOfRow = dataController.beginnerNestedDataArray.count
        case "MasterCollection":
            numberOfRow = dataController.masterNestedDataArray.count
        default:
            print("HomeListViewController tablView numberOfRow Error")
        }
        
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        switch bool {
        case "BeginnerCollection":
            let begCollections = dataController.beginnerNestedDataArray[indexPath.row]
            cell.textLabel?.text = "Please Watch \(begCollections.videoName!)"
        case "MasterCollection":
            let masterCollections = dataController.masterNestedDataArray[indexPath.row]
            cell.textLabel?.text = "Please Watch \(masterCollections.videoName!)"
        default:
            print("HomeListViewController tableView Show Data Error")
        }
        
        return cell
    }
    
}
