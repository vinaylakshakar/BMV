//
//  HomeVC.swift
//  BMV
//
//  Created by Silstone on 10/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var mapContainerView: UIView!
    @IBOutlet var offerContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func offersBtnAction(_ sender: UIButton)
    {
        if !sender.isSelected
        {
            sender.isSelected  = true
            mapContainerView.isHidden = true
        }else
        {
            sender.isSelected  = false
            mapContainerView.isHidden = false
        }
        
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
