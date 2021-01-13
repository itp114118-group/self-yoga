 //
 //  CoverViewController.swift
 //  Self-Yoga
 //
 //  Created by itst on 18/12/2020.
 //
 
 import UIKit
 import FirebaseFirestore
 
 class HomeViewController: UIViewController {
    
    @IBOutlet weak var begTableView: UITableView!
    @IBOutlet weak var masterTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var begView: UIView!
    @IBOutlet weak var masterView: UIView!

    var firestoreController = FirestoreController()
    var healthKitController = HealthKitController()
    
    var data = [String]()
    
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        firestoreController.fetchData() { collectionName, title, subtitle, duration, tempo, description in
            self.begTableView.reloadData()
            self.masterTableView.reloadData()
        }
        
        begTableView.dataSource = self
        begTableView.delegate = self
        
        masterTableView.dataSource = self
        masterTableView.delegate = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done

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
 
 extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            begTableView.reloadData()
            masterTableView.reloadData()
        } else {
            isSearching = true
            data = data.filter({$0.lowercased().contains((searchBar.text?.lowercased())!)})
            begTableView.reloadData()
            masterTableView.reloadData()
        }
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
            numberOfRow = firestoreController.beginnerDataArray.count
        case masterTableView:
            numberOfRow = firestoreController.masterDataArray.count
        default:
            print("HomeViewController tablView numberOfRow Error")
        }
        
        if isSearching {
            return data.count
        }
        
        return numberOfRow
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch tableView {
        case begTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "BeginnerCell", for: indexPath)
            let begCollections = firestoreController.beginnerDataArray[indexPath.row]
            if isSearching {
                let begCollections = data[indexPath.row]
            }
            cell.textLabel?.text = begCollections.title
            cell.detailTextLabel?.text = begCollections.subtitle
        case masterTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "MasterCell", for: indexPath)
            let masterCollections = firestoreController.masterDataArray[indexPath.row]
            if isSearching {
                let masterCollections = data[indexPath.row]
            }
            cell.textLabel?.text = masterCollections.title
            cell.detailTextLabel?.text = masterCollections.subtitle
        default:
            print("HomeViewController show data Error")
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
                print("HomeViewController prepare error")
            }
        }
        
        if let controller = segue.destination as? HomeDetailViewController {
            let beginnerIndexPath = begTableView.indexPathForSelectedRow
            let masterIndexPath = masterTableView.indexPathForSelectedRow
            
            switch segue.identifier {
            case "showBeginnerDetail":
                controller.bool = "BeginnerCollection"
                controller.yogaTitle = firestoreController.beginnerCollectionIndex(at: beginnerIndexPath!.row).title
                controller.duration = firestoreController.beginnerCollectionIndex(at: beginnerIndexPath!.row).duration
                controller.tempo = firestoreController.beginnerCollectionIndex(at: beginnerIndexPath!.row).tempo
                controller.yogaDescription = firestoreController.beginnerCollectionIndex(at: beginnerIndexPath!.row).description
            case "showMasterDetail":
                controller.bool = "MasterCollection"
                controller.yogaTitle = firestoreController.masterCollectionIndex(at: masterIndexPath!.row).title
                controller.duration = firestoreController.masterCollectionIndex(at: masterIndexPath!.row).duration
                controller.tempo = firestoreController.masterCollectionIndex(at: masterIndexPath!.row).tempo
                controller.yogaDescription = firestoreController.beginnerCollectionIndex(at: masterIndexPath!.row).description
            default:
                print("HomeViewController prepare error")
            }
        }
        
    }
    
 }
