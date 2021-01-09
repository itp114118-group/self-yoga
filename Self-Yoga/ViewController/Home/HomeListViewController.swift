//
//  HomeListViewController.swift
//  Self-Yoga
//
//  Created by Jack on 25/12/2020.
//

import UIKit

class HomeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataController = FirestoreController()
    var bool: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataController.fetchData() { collectionName, title, subtitle, duration, tempo, description in
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }

}

extension HomeListViewController: UITableViewDelegate, UITableViewDataSource {
   
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
            print("HomeListViewController tablView numberOfRow error")
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
            print("HomeListViewController tableView show data error")
        }
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? HomeDetailViewController {
            if segue.identifier == "showYogaSetDetail" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    switch bool {
                    case "BeginnerCollection":
                        controller.bool = "BeginnerCollection"
                        controller.yogaTitle = dataController.beginnerCollectionIndex(at: indexPath.row).title
                        controller.duration = dataController.beginnerCollectionIndex(at: indexPath.row).duration
                        controller.tempo = dataController.beginnerCollectionIndex(at: indexPath.row).tempo
                        controller.yogaDescription = dataController.beginnerCollectionIndex(at: indexPath.row).description
                    case "MasterCollection":
                        controller.bool = "MasterCollection"
                        controller.yogaTitle = dataController.masterCollectionIndex(at: indexPath.row).title
                        controller.duration = dataController.masterCollectionIndex(at: indexPath.row).duration
                        controller.tempo = dataController.masterCollectionIndex(at: indexPath.row).tempo
                        controller.yogaDescription = dataController.masterCollectionIndex(at: indexPath.row).description
                    default:
                        print("HomeListViewController prepare error")
                    }
                }
            }
        }
    }
   
}
