//
//  HomeListViewController.swift
//  Self-Yoga
//
//  Created by Jack on 25/12/2020.
//

import UIKit

class HomeListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var firestoreController = FirestoreController()
    var bool: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firestoreController.fetchData() { collectionName, title, subtitle, duration, tempo, description in
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
            numberOfRow = firestoreController.beginnerDataArray.count
        case "MasterCollection":
            numberOfRow = firestoreController.masterDataArray.count
        default:
            print("HomeListViewController tablView numberOfRow error")
        }
        return numberOfRow
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        switch bool {
        case "BeginnerCollection":
            let begCollections = firestoreController.beginnerDataArray[indexPath.row]
            cell.textLabel?.text = begCollections.title
            cell.detailTextLabel?.text = begCollections.subtitle
        case "MasterCollection":
            let masterCollections = firestoreController.masterDataArray[indexPath.row]
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
                    controller.yogaTitle = firestoreController.beginnerCollectionIndex(at: indexPath.row).title
                    controller.duration = firestoreController.beginnerCollectionIndex(at: indexPath.row).duration
                    controller.tempo = firestoreController.beginnerCollectionIndex(at: indexPath.row).tempo
                    controller.yogaDescription = firestoreController.beginnerCollectionIndex(at: indexPath.row).description
                    switch bool {
                    case "BeginnerCollection":
                        controller.bool = "BeginnerCollection"
                    case "MasterCollection":
                        controller.bool = "MasterCollection"
                    default:
                        print("HomeListViewController prepare error")
                    }
                }
            }
        }
    }
   
}
