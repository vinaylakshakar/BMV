//
//  ResultsMapVC.swift
//  BMV
//
//  Created by Silstone on 23/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class ResultsMapVC: UIViewController {

  
    @IBOutlet var resultsMapContainer: UIView!
    @IBOutlet var resultCollection: UIView!
    @IBOutlet var vipViewContainer: UIView!
    @IBOutlet var vipCollectionContainer: UIView!
    @IBOutlet var cancelNfcContainer: UIView!
    @IBOutlet var doneNfcContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(ResultsMapVC.frombeMyVipVC(notification:)), name: Notification.Name("frombeMyVipVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ResultsMapVC.fromeCancelNfc(notification:)), name: Notification.Name("fromeCancelNfc"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ResultsMapVC.fromeDoneNfc(notification:)), name: Notification.Name("fromeDoneNfc"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        vipViewContainer.isHidden = true
        cancelNfcContainer.isHidden = true
        doneNfcContainer.isHidden = true
        vipCollectionContainer.isHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func frombeMyVipVC(notification: Notification) {
        // Take Action on Notification
        vipCollectionContainer.isHidden = false
        vipViewContainer.isHidden = true
    }
    
    @objc func fromeCancelNfc(notification: Notification) {
        // Take Action on Notification
        cancelNfcContainer.isHidden = true
        doneNfcContainer.isHidden = false
    }
    @objc func fromeDoneNfc(notification: Notification) {
        // Take Action on Notification
        doneNfcContainer.isHidden = true
        vipViewContainer.isHidden = false
    }
    
    @IBAction func nfcBtnAction(_ sender: UIButton)
    {
        cancelNfcContainer.isHidden = false
    }
    
    @IBAction func flipResultsAction(_ sender: UIButton)
    {
        if (!sender.isSelected)
        {
            sender.isSelected = true
            resultsMapContainer.isHidden = true
        }else
        {
            sender.isSelected = false
            resultsMapContainer.isHidden = false
        }
        
    }
    @IBAction func profileBtnAction(_ sender: UIButton)
    {
        let tabBAr = self.storyboard?.instantiateViewController(withIdentifier: "profileTabBar") as! UITabBarController
        self.navigationController?.pushViewController(tabBAr, animated: true)
    }
    @IBAction func settingBtnAction(_ sender: UIButton)
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "FiltersVC") as! FiltersVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}
