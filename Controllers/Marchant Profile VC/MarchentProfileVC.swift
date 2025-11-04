//
//  MarchentProfileVC.swift
//  BMV
//
//  Created by Silstone on 07/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class MarchentProfileVC: UIViewController {

    @IBOutlet var checkedInContainer: UIView!
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
    @IBAction func chekedInTap(_ sender: UITapGestureRecognizer)
    {
        checkedInContainer.isHidden = true
    }
    
}
