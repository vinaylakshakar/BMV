//
//  BeMyVipVC.swift
//  BMV
//
//  Created by Silstone on 03/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class BeMyVipVC: UIViewController {

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
    @IBAction func vipBtnAction(_ sender: UIButton)
    {
        NotificationCenter.default.post(name: Notification.Name("frombeMyVipVC"), object: nil)
    }
    
}
