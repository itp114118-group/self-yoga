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
    @IBOutlet weak var masterTableView: UITableView!
    @IBOutlet weak var begView: UIView!
    @IBOutlet weak var masterView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataController = DataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        dataController.fetchData() { collectionName, title, subtitle, duration, tempo, description in
            self.begTableView.reloadData()
            self.masterTableView.reloadData()
        }
        
        begTableView.dataSource = self
        begTableView.delegate = self
        
        masterTableView.dataSource = self
        masterTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        
        begView.layer.cornerRadius = 20
        begView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        masterView.layer.cornerRadius = 20
        masterView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        begTableView.layer.cornerRadius = 20
        begTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        masterTableView.layer.cornerRadius = 20
        masterTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
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
        case masterTableView:
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
        case masterTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)
            let masterCollections = dataController.masterDataArray[indexPath.row]
            cell.textLabel?.text = masterCollections.title
            cell.detailTextLabel?.text = masterCollections.subtitle
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
        if let controller = segue.destination as? HomeListViewController {
            switch segue.identifier {
            case "showBeginnerCollection":
                controller.bool = "BeginnerCollection"
            case "showMasterCollection":
                controller.bool = "MasterCollection"
            default:
                print("Error")
            }
        }
        
        if let controller = segue.destination as? HomeDetailViewController {
            let beginnerIndexPath = begTableView.indexPathForSelectedRow
            let masterIndexPath = masterTableView.indexPathForSelectedRow
            
            switch segue.identifier {
            case "showBeginnerDetail":
                controller.bool = "BeginnerCollection"
                controller.yogaTitle = dataController.beginnerCollectionIndex(at: beginnerIndexPath!.row).title
                controller.duration = dataController.beginnerCollectionIndex(at: beginnerIndexPath!.row).duration
                controller.tempo = dataController.beginnerCollectionIndex(at: beginnerIndexPath!.row).tempo
                controller.yogaDescription = dataController.beginnerCollectionIndex(at: beginnerIndexPath!.row).description
            case "showMasterDetail":
                controller.bool = "MasterCollection"
                controller.yogaTitle = dataController.masterCollectionIndex(at: masterIndexPath!.row).title
                controller.duration = dataController.masterCollectionIndex(at: masterIndexPath!.row).duration
                controller.tempo = dataController.masterCollectionIndex(at: masterIndexPath!.row).tempo
                controller.yogaDescription = dataController.beginnerCollectionIndex(at: masterIndexPath!.row).description
            default:
                print("Error")
            }
        }
        
    }
    
 }
