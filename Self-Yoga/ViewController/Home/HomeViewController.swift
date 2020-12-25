 //
 //  CoverViewController.swift
 //  Self-Yoga
 //
 //  Created by itst on 18/12/2020.
 //
 
 import UIKit
 import CoreData
 import FirebaseFirestore
 
 class HomeViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var begTableView: UITableView!
    @IBOutlet weak var MasterTableView: UITableView!
    
    @IBOutlet weak var begView: UIView!
    @IBOutlet weak var masterView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        dataController.fetchData() { title, subtitle in
            self.begTableView.reloadData()
            self.MasterTableView.reloadData()
        }
        
        begTableView.dataSource = self
        begTableView.delegate = self
        
        MasterTableView.dataSource = self
        MasterTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        
        begView.layer.cornerRadius = 20
        begView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        masterView.layer.cornerRadius = 20
        masterView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        begTableView.layer.cornerRadius = 20
        begTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        MasterTableView.layer.cornerRadius = 20
        MasterTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
 }
 
 extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        
        switch tableView {
        case begTableView:
            numberOfRow = dataController.beginnerDataArray.count
        case MasterTableView:
            numberOfRow = dataController.masterDataArray.count
        default:
            print("Error")
        }
        return numberOfRow
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch tableView {
        case begTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "BeginnerCell", for: indexPath)
            let begCollections = dataController.beginnerDataArray[indexPath.row]
            cell.textLabel?.text = begCollections.title
            cell.detailTextLabel?.text = begCollections.subtitle
        case MasterTableView:
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
        if segue.identifier == "showBeginnerCollection" {
            if let controller = segue.destination as? HomeListViewController {

                    controller.bool = 
                
            }
        }
        
        if segue.identifier == "showMasterCollection" {
            if let controller = segue.destination as? HomeListViewController {

                    controller.bool = "MasterCollection"
                
            }
        }
    }
    
    
 }
