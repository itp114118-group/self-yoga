 //
 //  CoverViewController.swift
 //  Self-Yoga
 //
 //  Created by itst on 18/12/2020.
 //
 
 import UIKit
 import CoreData
 import FirebaseFirestore
 
 class CoverViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var begTableView: UITableView!
    @IBOutlet weak var MasterTableView: UITableView!
    
    @IBOutlet weak var begView: UIView!
    @IBOutlet weak var masterView: UIView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var yogasets : [YogaSet]?
    
    var db: Firestore!
    
    var dataController = DataController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        
        initUI()
        
        fetchData()
        
        begTableView.dataSource = self
        begTableView.delegate = self
        
        MasterTableView.dataSource = self
        MasterTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func fetchData() {
        db.collection("YogaSet").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let title = data["title"] as? String ?? ""
                    let subtitle = data["subtitle"] as? String ?? ""
                    
                    let yogaSet = YogaSet(title: title, subtitle: subtitle)
                    self.dataController.dataArray.append(yogaSet)
                    
                    self.begTableView.reloadData()
                }
                self.begTableView.reloadData()
            }
            self.begTableView.reloadData()
        }
        self.begTableView.reloadData()
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
 
 extension CoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
//        if dataController.dataArray.count > 0 {
            let begCollections = dataController.dataArray[indexPath.row]
            cell.textLabel?.text = begCollections.title
            cell.detailTextLabel?.text = begCollections.subtitle
//        }
        
        return cell
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
