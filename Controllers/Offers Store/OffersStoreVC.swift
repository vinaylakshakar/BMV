//
//  OffersStoreVC.swift
//  BMV
//
//  Created by Silstone on 13/11/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import iProgressHUD

class OffersStoreVC: UIViewController {

    var callApi = HttpClientApi()
     var offset = 0
    @IBOutlet var mapContainerView: UIView!
    @IBOutlet var offerContainerView: UIView!
    @IBOutlet var cancelNfcContainer: UIView!
    @IBOutlet var doneNfcContainer: UIView!
    @IBOutlet var vipViewContainer: UIView!
    @IBOutlet var vipCollectionContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         iProgressHUD.sharedInstance().attachProgress(toView: self.view)
         NotificationCenter.default.addObserver(self, selector: #selector(ResultsMapVC.frombeMyVipVC(notification:)), name: Notification.Name("frombeMyVipVC"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ResultsMapVC.fromeCancelNfc(notification:)), name: Notification.Name("fromeCancelNfc"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ResultsMapVC.fromeDoneNfc(notification:)), name: Notification.Name("fromeDoneNfc"), object: nil)
        
        let param = "userid=\(UserDefaults.standard.string(forKey: kUserId)!)&latitude=\("1.34")&longitude=\("3.144")&offset=\(offset)"
       // get_AllStores(param: param)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
         vipViewContainer.isHidden = true
        cancelNfcContainer.isHidden = true
        doneNfcContainer.isHidden = true
        vipCollectionContainer.isHidden = true
    }

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: API Methods
    func get_AllStores(param:String)  {
        view.showProgress()
        callApi.callGetApi(apiFor: "get_AllStores", parameters: param) { (response) in
                                print(response.result.value ?? "")
                                if  response.result.isSuccess{
                                    let value = response.result.value as! [String:Any]
                                    print(value)
                                    let mess =  "\(String(describing: value["message"] ?? value["Message"]!))"
                                   // let status = value["status"] as! String
                                     self.view.dismissProgress()
                                   // self.PresentAlert(message:mess,title:"BMV")
                                    if mess == "success"{
                                       
                                        let value = response.result.value as! [String:Any]
                                        print(value)
//                                        self.offersArray  = value["data"] as! [NSDictionary]
//                                        self.collectionView.reloadData()
                                        //self.showAlrt(messageStr: "Registered Successfully")
                                        // self.showAlrt(messageStr: "Registered Successfully")
                                        
                                    }else{
                                       self.view.dismissProgress()
                                        self.showAlrt(messageStr: mess)

                                    }
                                }else{
        //                           // self.PresentAlert(message: "Could't connect to server", title: "BMV")
                                    self.showAlrt(messageStr: "Could't connect to server")
                                    self.view.dismissProgress()
        //                        }
                                }
                                
                            }
    }
    func showAlrt(messageStr:String)
    {
        let alertController = UIAlertController(title: "BMV", message: messageStr, preferredStyle: UIAlertController.Style.alert)

        let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                           print("OK")
                       }

               alertController.addAction(OkAction)
               self.present(alertController, animated: true, completion: nil)
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

}
