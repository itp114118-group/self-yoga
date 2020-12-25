//
//  HomeListViewController.swift
//  Self-Yoga
//
//  Created by Jack on 25/12/2020.
//

import UIKit

class HomeListViewController: UIViewController {

    var dataController = DataController()
    
    @IBOutlet weak var tableView: UITableView!
    
    var bool: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataController.fetchData() { title, subtitle in
            self.tableView.reloadData()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
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

extension HomeListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        
        switch bool {
        case "showBeginnerCollection":
            numberOfRow = dataController.beginnerDataArray.count
        case "showMasterCollection":
            numberOfRow = dataController.masterDataArray.count
        default:
            print("Error")
        }
        return numberOfRow
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch bool {
        case "showBeginnerCollection":
            cell = tableView.dequeueReusableCell(withIdentifier: "BeginnerCell", for: indexPath)
            let begCollections = dataController.beginnerDataArray[indexPath.row]
            cell.textLabel?.text = begCollections.title
            cell.detailTextLabel?.text = begCollections.subtitle
        case "showMasterCollection":
            cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)
            let begCollections = dataController.masterDataArray[indexPath.row]
            cell.textLabel?.text = begCollections.title
            cell.detailTextLabel?.text = begCollections.subtitle
        default:
            print("Error")
        }
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

    }
   
}
