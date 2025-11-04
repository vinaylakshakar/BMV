//
//  OffersVC.swift
//  BMV
//
//  Created by Silstone on 13/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import iProgressHUD

class OffersVC: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
     var callApi = HttpClientApi()
    @IBOutlet var collectionView: UICollectionView!
    var offset = 0
    var offersArray = [NSDictionary]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

         iProgressHUD.sharedInstance().attachProgress(toView: self.view)
          collectionView.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "OffersCell")
        // Register to receive notification in your class
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshList), name: NSNotification.Name(rawValue: "OfferVCNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.OfferVCFilter), name: NSNotification.Name(rawValue: "OfferVCFilter"), object: nil)


        // Do any additional setup after loading the view.
        if !appDelegate.isOfferFilter {
            let param = "userid=\(UserDefaults.standard.string(forKey: kUserId)!)&latitude=\("1.34")&longitude=\("3.144")&offset=\(offset)"
            get_AllOffers(param: param)
            //for filter
        }
        
//        let catListtring = json(from: [["Categoryid": "1","Categoryname": "Pants"
//        ]])
//        let param = "UserId=\(UserDefaults.standard.string(forKey: kUserId)!)&minPrice=\("100")&maxPrice=\("10000")&latitude=\("1.34")&logitude=\("3.144")&offset=\(offset)&catList=\(catListtring!)"
//        get_filterOffers(param: param)
    }
    
    
    @objc func refreshList(notification: NSNotification){
        let dict = notification.object as! NSDictionary
        let offerIndex = dict["offerIndex"] as? NSInteger
        var offerDict = self.offersArray[offerIndex!] as! [String: Any]
        let IsBookMarked = offerDict["IsBookMarked"] as! Bool
        if IsBookMarked {
            
            offerDict["IsBookMarked"] = false
        }else{
            
            offerDict["IsBookMarked"] = true
        }
        offersArray[offerIndex!] = offerDict as NSDictionary
        collectionView.reloadData()
    }

    @objc func OfferVCFilter(notification: NSNotification){
        let dict = notification.object as! NSDictionary
        print(dict)
//        let catListtring = json(from: dict["catList"]!)
//        let param = "UserId=\(UserDefaults.standard.string(forKey: kUserId)!)&minPrice=\("100")&maxPrice=\("10000")&latitude=\("1.34")&logitude=\("3.144")&offset=\(offset)&catList=\(catListtring!)"
//        get_filterOffers(param: param)
        
        //getFilter-
//        let catListtring = json(from: [["Categoryid": "1","Categoryname": "Pants"
//        ]])
        let param = "UserId=\(UserDefaults.standard.string(forKey: kUserId)!)&minPrice=\("100")&maxPrice=\("10000")&latitude=\("1.34")&logitude=\("3.144")&offset=\(offset)&catList=\(dict["catList"]!)"
        get_filterOffers(param: param)
    }
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
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
    func get_AllOffers(param:String)  {
        view.showProgress()
        callApi.callGetApi(apiFor: "get_AllOffers", parameters: param) { (response) in
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
                                        self.offersArray  = value["data"] as! [NSDictionary]
                                        self.collectionView.reloadData()
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
    
    func get_filterOffers(param:String)  {
        view.showProgress()
        callApi.callPostJsonApi(apiFor: "get_filterOffers", parameters: param) { (response) in
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
                                        self.offersArray  = value["data"] as! [NSDictionary]
                                        self.collectionView.reloadData()
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
    
    func bookmark_offer(paramsDict: NSDictionary,status:String)  {
                       // view.showProgress()
        //view.showProgress()
        let param = "userid=\(UserDefaults.standard.string(forKey: kUserId)!)&offerid=\(String(describing: paramsDict["Id"]!))&IsBookmarked=\(status)"
                       
                        callApi.callPostApi(apiFor: "bookmark_offer", parameters: param) { (response) in
                            print(response.result.value ?? "")
                            if  response.result.isSuccess{
                                let value = response.result.value as! [String:Any]
                                print(value)
                                let mess =  "\(String(describing: value["message"] ?? value["Message"]!))"
                               // let status = value["status"] as! String
                                //self.view.dismissProgress()
                               // self.PresentAlert(message:mess,title:"BMV")
                                if mess == "success"{
                                   
                                    let value = response.result.value as! [String:Any]
                                  print(value)
                                }else
                                {
                                    self.showAlrt(messageStr: mess)
                                                   
                                }
                            }else{
    //                           // self.PresentAlert(message: "Could't connect to server", title: "BMV")
                                self.showAlrt(messageStr: "Could't connect to server.")
                                //self.view.dismissProgress()
                           }
                        }
                    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return offersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCell", for: indexPath) as! OffersCell
        
        let offerDict = offersArray[indexPath.row]
        cell.offerType.text = offerDict["OfferType"] as? String
        cell.offerPrice.text = "$\(String(describing: offerDict["OfferPrice"]!))"
        let IsBookMarked = offerDict["IsBookMarked"] as! Bool
        if IsBookMarked {
            cell.bookmarkImage.image  = UIImage.init(named: "Group 11")
        }else{
            cell.bookmarkImage.image  = UIImage.init(named: "Group 23")
        }
        cell.btnBookmark.tag = indexPath.row
        cell.btnBookmark.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        //cell.offerType.text = offerDict["OfferType"] as! String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.bounds.size.width/2-10, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let StoreDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "OfferDetailsScreen") as! StoreDetailsVC
        StoreDetailsVC.offerId = "\(String(describing: offersArray[indexPath.row]["Id"]!))"
        StoreDetailsVC.offerIndex = indexPath.row
        self.present(StoreDetailsVC, animated: true, completion: nil)
    }
    @objc func buttonClicked(sender:UIButton)
    {
        var offerDict = offersArray[sender.tag] as! [String: Any]
        let indexPath = NSIndexPath(item: sender.tag, section: 0) // set section as you want
        let cell = collectionView.cellForItem(at: indexPath as IndexPath) as! OffersCell
        
        let IsBookMarked = offerDict["IsBookMarked"] as! Bool
        if IsBookMarked {
            cell.bookmarkImage.image  = UIImage.init(named: "Group 11")
            cell.bookmarkImage.image  = UIImage.init(named: "Group 23")
            bookmark_offer(paramsDict: offerDict as NSDictionary, status: "false")
            offerDict["IsBookMarked"] = false
        }else{
            cell.bookmarkImage.image  = UIImage.init(named: "Group 23")
            cell.bookmarkImage.image  = UIImage.init(named: "Group 11")
            bookmark_offer(paramsDict: offerDict as NSDictionary, status: "true")
            offerDict["IsBookMarked"] = true
        }
        
        offersArray[sender.tag] = offerDict as NSDictionary
        collectionView.reloadData()
        print("hello")
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
}
