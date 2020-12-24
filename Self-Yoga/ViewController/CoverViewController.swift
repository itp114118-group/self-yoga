 //
//  CoverViewController.swift
//  Self-Yoga
//
//  Created by itst on 18/12/2020.
//

import UIKit

class CoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var begTableView: UITableView!
    @IBOutlet weak var MasterTableView: UITableView!

    @IBOutlet weak var begView: UIView!
    @IBOutlet weak var masterView: UIView!
    
    let myArray = ["Cat", "Dog", "Snake", "Spider", "Horse"]
    let myArray2 = ["Mouse"]
    
    var yoga: YogaSet?
    var dataController = DataController()
    
    var yogaTitle: String?
    var yogaSubtitle: String?
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
//        cell.textLabel!.text = myArray[indexPath.row]
        
        if dataController.dataArray.count > 0 {
            let begCollections = dataController.dataArray[indexPath.row]
            cell.textLabel?.text = begCollections.title
            cell.detailTextLabel?.text = begCollections.subtitle
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
