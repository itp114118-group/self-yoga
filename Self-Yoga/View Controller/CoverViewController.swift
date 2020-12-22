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
    let myArray = ["Cat", "Dog", "Snake", "Spider", "Horse", "Mouse"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularTableView.layer.cornerRadius = 20
        popularTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        popularTableView.dataSource = self
        popularTableView.delegate = self
        
        begTableView.layer.cornerRadius = 20
        begTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        begTableView.dataSource = self
        begTableView.delegate = self
        
        MasterTableView.layer.cornerRadius = 20
        MasterTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        MasterTableView.dataSource = self
        popularTableView.delegate = self

        // Do any additional setup after loading the view.
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
