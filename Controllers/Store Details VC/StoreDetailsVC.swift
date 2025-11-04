//
//  StoreDetailsVC.swift
//  BMV
//
//  Created by Silstone on 24/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import TTGTagCollectionView
import iProgressHUD

class StoreDetailsVC: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    var callApi = HttpClientApi()
    @IBOutlet var imageCollectionView: UICollectionView!
    @IBOutlet var tagCollectionView: TTGTagCollectionView!
    var tagsArray = [String]()
    var InterestTagViews: [UILabel] = []
    var offerId = ""
    var offerIndex = 0
    var offerDetailDict = [String: Any]()
    @IBOutlet var dicountTypelbl: UILabel!
    @IBOutlet var offerPricelbl: UILabel!
    @IBOutlet var itemNamelbl: UILabel!
    @IBOutlet var storeNamelbl: UILabel!
    @IBOutlet var storeImage: UIImageView!
    @IBOutlet var storeTimelbl: UILabel!
    @IBOutlet var isOpenlbl: UILabel!
    @IBOutlet var bookmarkBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tagsArray = ["Interior","Exterior","Handicrafts","Footwear","Garden","Designing","Lorem Ipsum Interests"]
        // Do any additional setup after loading the view.
        iProgressHUD.sharedInstance().attachProgress(toView: self.view)
        let userid = UserDefaults.standard.string(forKey: kUserId)
        let param = "userid=\(userid!)&offerid=\(offerId)"
        getOffer_details(param: param)
       // setLayout()
        //TagConfiguration()
    }
    
    func setLayout() {
        self.dicountTypelbl.text = offerDetailDict["discoutType"] as? String
        self.offerPricelbl.text =  "$\(String(describing: offerDetailDict["offerPrice"]!))"
        self.itemNamelbl.text = offerDetailDict["itemName"] as? String
        self.storeNamelbl.text = offerDetailDict["storeName"] as? String
        self.storeTimelbl.text = offerDetailDict["storeTime"] as? String
        if let isOpen = offerDetailDict["isOpen"] as? Bool{
            if isOpen {
                 self.isOpenlbl.text = "OPEN"
            }else{
                 self.isOpenlbl.text = "CLOSED"
            }
            print("isOpen",isOpen)
        }
        
        
        if let IsBookMarked = offerDetailDict["isBookMarked"] as? Bool{
            if IsBookMarked {
                bookmarkBtn.isSelected = true
                //cell.bookmarkImage.image  = UIImage.init(named: "Group 11")
            }else{
                bookmarkBtn.isSelected = false
                //cell.bookmarkImage.image  = UIImage.init(named: "Group 23")
            }
            print("IsBookMarked",IsBookMarked)
        }
        
    }
    //MARK:api methods
        func getOffer_details(param:String)  {
                view.showProgress()
                callApi.callGetApi(apiFor: "getOffer_details", parameters: param) { (response) in
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
                                                self.offerDetailDict = value["data"] as! [String : Any]
                                                self.setLayout()
                                                
                                      
                                            }else{
                                              // self.view.dismissProgress()
                                              //  self.showAlrt(messageStr: mess)

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
        let param = "userid=\(UserDefaults.standard.string(forKey: kUserId)!)&offerid=\(String(describing: paramsDict["offerid"]!))&IsBookmarked=\(status)"
                       
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
                                   

                                    let myDict = [ "offerIndex": self.offerIndex]
                                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "OfferVCNotification"), object:myDict);
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
    func showAlrt(messageStr:String)
     {
         let alertController = UIAlertController(title: "BMV", message: messageStr, preferredStyle: UIAlertController.Style.alert)

         let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                            print("OK")
                        }

                alertController.addAction(OkAction)
                self.present(alertController, animated: true, completion: nil)
     }
    
    // MARK: - Create item Tag
    func TagConfiguration()  {
        let config = TTGTextTagConfig()
        config.shadowColor = hexStringToUIColor(hex: "#000000")
        // config.shadowColor = (hexStringToUIColor(hex: "#000000").cgColor)
        config.shadowRadius = 6.0
        //        config.shadowOpacity = CGPath(rect:  CGRect(x: 0, y:3, width: 0, height: 0), transform: nil)
        config.shadowOpacity = 0.16
        config.shadowOffset = CGSize(width: 0, height: 3)
        config.enableGradientBackground = true
        config.extraSpace = CGSize(width: 10, height: 10)
        config.selectedBackgroundColor = UIColor(red: 0.97, green: 0.64, blue: 0.27, alpha: 1.00)

        //feeling tag cv
        tagCollectionView.alignment = .fillByExpandingWidthExceptLastLine
        tagCollectionView.horizontalSpacing = 10
        tagCollectionView.verticalSpacing = 10
        tagCollectionView.scrollDirection = .horizontal
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
        tagCollectionView.reload()

    }
    @IBAction func storeCallAction(_ sender: UIButton) {
        
        if let call = offerDetailDict["storeMobile"] as? String,
            let url = URL(string: "tel://\(call)"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func bookmarkAction(_ sender: UIButton) {
        
        if !sender.isSelected {
            sender.isSelected = true
            bookmark_offer(paramsDict: offerDetailDict as NSDictionary, status: "true")
        }else{
            sender.isSelected = false
            bookmark_offer(paramsDict: offerDetailDict as NSDictionary, status: "false")
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)

        let imageView: UIImageView = UIImageView(image: UIImage(named: "Layer 1-4"))
        imageView.frame = cell.contentView.frame
        imageView.contentMode = .scaleAspectFill
        cell.contentView.addSubview(imageView)
        return cell
        
    }
}
//MARK: TTGTagCollectionView Extenstion delegate
extension StoreDetailsVC : TTGTagCollectionViewDelegate,TTGTagCollectionViewDataSource{


func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
   
    let size = (tagsArray[Int(index)] as NSString).size(withAttributes:nil)
       let width = size.width + 40
       let height = size.height + 25
    return  CGSize(width: width, height: height)
}
func numberOfTags(in tagCollectionView: TTGTagCollectionView!) -> UInt {

    return UInt(tagsArray.count)

}
func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, tagViewFor index: UInt) -> UIView! {
    
        let taglabel = UILabel()
        taglabel.tag = Int(index)
        InterestTagViews.append(taglabel)
        taglabel.font = UIFont(name:"SegoeUI-Semibold", size: 15)
        taglabel.textColor = hexStringToUIColor(hex:"#3E3E3E")
        taglabel.textAlignment = .center
        taglabel.sizeToFit()
        taglabel.numberOfLines = 1
        taglabel.contentMode = .center
        taglabel.alpha = 1
        taglabel.lineBreakMode = .byTruncatingTail
        taglabel.adjustsFontSizeToFitWidth = true
        taglabel.backgroundColor = UIColor(red:0.99, green:0.94, blue:0.95, alpha:1.0)
        taglabel.text = tagsArray[Int(index)]
        taglabel.CornerRadius(19)
        return InterestTagViews[Int(index)]

}

func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView?, didTapTag tagText: String?, at index: Int, selected: Bool, tagConfig config: TTGTextTagConfig?) {
    let stringTag = String(format: "Tap tag: %@, at: %ld, selected: %d", tagText ?? "", index, selected)
    print(stringTag)
}

func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, didSelectTag tagView: UIView!, at index: UInt) {
    if tagView.backgroundColor == UIColor(red:0.73, green:0.00, blue:0.00, alpha:1.0)
    {
        tagView.backgroundColor = UIColor(red:0.99, green:0.94, blue:0.95, alpha:1.0)
    }
    else
    {
        tagView.backgroundColor = UIColor(red:0.73, green:0.00, blue:0.00, alpha:1.0)
    }
    
}
}
