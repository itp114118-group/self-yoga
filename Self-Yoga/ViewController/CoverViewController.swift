 //
//  CoverViewController.swift
//  Self-Yoga
//
//  Created by itst on 18/12/2020.
//

import UIKit

class CoverViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var popularTableView: UITableView!
    @IBOutlet weak var begTableView: UITableView!
    @IBOutlet weak var MasterTableView: UITableView!

    @IBOutlet weak var popularView: UIView!
    @IBOutlet weak var begView: UIView!
    @IBOutlet weak var masterView: UIView!
    
    let myArray = ["Cat", "Dog", "Snake", "Spider", "Horse", "Mouse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        
        popularTableView.dataSource = self
        popularTableView.delegate = self
        
        begTableView.dataSource = self
        begTableView.delegate = self
        
        MasterTableView.dataSource = self
        popularTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        
        popularView.layer.cornerRadius = 20
        popularView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        begView.layer.cornerRadius = 20
        begView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        masterView.layer.cornerRadius = 20
        masterView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        popularTableView.layer.cornerRadius = 20
        popularTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        begTableView.layer.cornerRadius = 20
        begTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        MasterTableView.layer.cornerRadius = 20
        MasterTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel!.text = myArray[indexPath.row]
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
