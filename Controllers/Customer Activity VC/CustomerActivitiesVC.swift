//
//  CustomerActivitiesVC.swift
//  BMV
//
//  Created by Silstone on 07/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import MGStarRatingView

class CustomerActivitiesVC: UIViewController,StarRatingDelegate{


   
    @IBOutlet var filterView: UIView!
    @IBOutlet var filterTable: UITableView!
    @IBOutlet var starRating: StarRatingView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let attribute = StarRatingAttribute(type: .rate,
                                            point: 18,
                                            spacing: 6,
                                            emptyColor: UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0),
                                            fillColor: UIColor(red:0.97, green:0.74, blue:0.18, alpha:1.0),
                                            emptyImage: nil,
                                            fillImage: nil)
        starRating.configure(attribute, current: 4, max: 5)
        starRating.delegate = self
    }
    
    func StarRatingValueChanged(view: StarRatingView, value: CGFloat) {
        print("rating changed")
    }
    
    @IBAction func showFilterAction(_ sender: UIButton)
    {
        filterView.isHidden = false
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

extension CustomerActivitiesVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == filterTable
        {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
            
            if cell == nil
            {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellIdentifier")
            }
            
             cell!.textLabel?.text = "call"
            cell!.textLabel?.font = UIFont.systemFont(ofSize: 12)
            return cell!
        }
        
        let cellReuseIdentifier = "ActivityCell" + "\(indexPath.row)"
        let cell:ActivityCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ActivityCell
        
        //        cell.myView.backgroundColor = self.colors[indexPath.row]
        //        cell.myCellLabel.text = self.animals[indexPath.row]
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        if tableView == self.filterTable {
            filterView.isHidden = true
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 272
    //    }
}
