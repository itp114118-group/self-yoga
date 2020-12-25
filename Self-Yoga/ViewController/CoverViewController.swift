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
    
    var ref: DocumentReference? = nil
    var db: Firestore!
    
    var yogasets : [YogaSet]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.searchAndReloadTable(query: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        db = Firestore.firestore()
         
        initData()
        
        begTableView.dataSource = self
        begTableView.delegate = self
        
        MasterTableView.dataSource = self
        MasterTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func initData() {
        db.collection("YogaSet").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let data = document.data()
                    let title = data["title"] as? String ?? ""
                    let subtitle = data["subtitle"] as? String ?? ""
                    
                    print(title)
                    print(subtitle)
                }
            }
        }
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
    
    func searchAndReloadTable(query:String) {
        if let managedObjectContext = self.managedObjectContext {
            let fetchRequest = NSFetchRequest<YogaSet>(entityName: "YogaSet")
            if query.count > 0 {
                let predicate = NSPredicate(format: "name contains[cd] %@", query)
                fetchRequest.predicate = predicate
            }
            do {
                let theDevices = try managedObjectContext.fetch(fetchRequest)
                self.yogasets = theDevices
                self.begTableView.reloadData()
                self.MasterTableView.reloadData()
            } catch {
                
            }
        }
    }
    
    var managedObjectContext : NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        }
        return nil;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

              // filterdata  = searchText.isEmpty ? data : data.filter {(item : String) -> Bool in
        
        searchAndReloadTable(query: searchBar.text!)

              //return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil

        self.begTableView.reloadData()
        self.MasterTableView.reloadData()
      }
 }
 
 extension CoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let yogasets = self.yogasets {
            return yogasets.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        //        if dataController.dataArray.count > 0 {
        //            let begCollections = dataController.dataArray[indexPath.row]
        //            cell.textLabel?.text = begCollections.title
        //            cell.detailTextLabel?.text = begCollections.subtitle
        //        }
        
        if let yogaset = self.yogasets?[indexPath.row] {
            cell.textLabel?.text = yogaset.title
            cell.detailTextLabel?.text = "\(yogaset.subtitle)"
        }
        
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
