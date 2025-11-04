//
//  StoresVC.swift
//  BMV
//
//  Created by Silstone on 20/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class StoresVC: UIViewController {

    @IBOutlet var storeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

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

extension StoresVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "StoreViewCell"
        let cell:StoreViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! StoreViewCell
        
        //        cell.myView.backgroundColor = self.colors[indexPath.row]
        //        cell.myCellLabel.text = self.animals[indexPath.row]
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 272
//    }
}

