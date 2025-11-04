//
//  CustomerListVC.swift
//  BMV
//
//  Created by Silstone on 09/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import MGStarRatingView

class CustomerListVC: UIViewController,StarRatingDelegate {


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

    func StarRatingValueChanged(view: StarRatingView, value: CGFloat) {
        print("rating changed")
    }
    
    func showRating(ratingView: StarRatingView)
    {
        let attribute = StarRatingAttribute(type: .rate, point: 18,
                                            spacing: 6,
                                            emptyColor: UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0),
                                            fillColor: UIColor(red:0.97, green:0.74, blue:0.18, alpha:1.0),
                                            emptyImage: nil,
                                            fillImage: nil)
        ratingView.configure(attribute, current: 4, max: 5)
        ratingView.delegate = self
    }
    
    
}

extension CustomerListVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "CustomerListCell"
        var cell: CustomerListCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomerListCell
        if cell == nil {
            tableView.register(UINib(nibName: "CustomerListCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomerListCell
        }
        
        showRating(ratingView: cell.ratingStar)
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
