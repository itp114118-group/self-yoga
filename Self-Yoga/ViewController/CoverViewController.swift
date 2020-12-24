 //
 //  CoverViewController.swift
 //  Self-Yoga
 //
 //  Created by itst on 18/12/2020.
 //
 
 import UIKit
 import CoreData
 
 class CoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var begTableView: UITableView!
    @IBOutlet weak var MasterTableView: UITableView!
    
    @IBOutlet weak var begView: UIView!
    @IBOutlet weak var masterView: UIView!
    
    var yogasets : [YogaSet]?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchAndReloadTable(query: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        begTableView.dataSource = self
        begTableView.delegate = self
        
        MasterTableView.dataSource = self
        
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
    
    var managedObjectContext : NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        }
        return nil;
    }
    
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
