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
    var yogatitle: String?
    var duration: String?
    var tempo: String?
    var yogadescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = yogatitle
        durationLabel.text = duration
        tempoLabel.text = tempo
        descriptionLabel.text = yogadescription
        
        dataController.fetchData() { collectionName, title, subtitle, duration, tempo, description in
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
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
            numberOfRow = dataController.beginnerDataArray.count
        case "MasterCollection":
            numberOfRow = dataController.masterDataArray.count
        default:
            print("HomeListViewController tablView numberOfRow Error")
        }
        
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        switch bool {
        case "BeginnerCollection":
            let begCollections = dataController.beginnerDataArray[indexPath.row]
            cell.textLabel?.text = begCollections.title
            cell.detailTextLabel?.text = begCollections.subtitle
        case "MasterCollection":
            let masterCollections = dataController.masterDataArray[indexPath.row]
            cell.textLabel?.text = masterCollections.title
            cell.detailTextLabel?.text = masterCollections.subtitle
        default:
            print("HomeListViewController tableView Show Data Error")
        }
        
        return cell
    }
    
}
