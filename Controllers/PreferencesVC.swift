//
//  PreferencesVC.swift
//  BMV
//
//  Created by Silstone on 11/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import TTGTagCollectionView
import iProgressHUD

class PreferencesVC: UIViewController {
        
    var callApi = HttpClientApi()
    var interestArray = [NSDictionary]()
    var selectedCategoryArray = [NSDictionary]()
    var SearchArr = [NSDictionary]()
    @IBOutlet var tagColectionVIew: TTGTagCollectionView!
    var InterestTagViews: [UILabel] = []
    @IBOutlet var searchField: UITextField!
    var filtered = [NSDictionary]()
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        //interestArray = ["Style", "Design", "Travel", "Politics", "Art", "World", "Sport", "TV", "Gaming", "Economy", "Food", "Comics", "History", "Culture", "Film", "Music", "Work"]
        //TagConfiguration()
        iProgressHUD.sharedInstance().attachProgress(toView: self.view)
        let param = "userid=\("0")"
        self.get_preferences(param: param)
        
        searchField.addTarget(self, action: #selector(PreferencesVC.textFieldDidChange(_:)),
        for: UIControl.Event.editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

     // filter tableViewData with textField.text
       print("interestArray",interestArray)

        let searchText  = textField.text
        filtered = self.SearchArr.filter({
        let string = $0["CategoryName"] as! String

        return string.hasPrefix(searchText ?? "")
        }) 
        if(filtered.count == 0 && !(searchText != nil)){
            searchActive = false;
            interestArray = self.SearchArr
        } else {
            searchActive = true;
            interestArray = filtered
        }
        
        print(interestArray)
        InterestTagViews.removeAll()
        self.tagColectionVIew.delegate = self
        self.tagColectionVIew.dataSource = self
        tagColectionVIew.reload()
       

    }
    
      // MARK: - setupTagConfiguration
    
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
        tagColectionVIew.alignment = .fillByExpandingWidthExceptLastLine
        tagColectionVIew.horizontalSpacing = 10
        tagColectionVIew.verticalSpacing = 10
        self.tagColectionVIew.delegate = self
        self.tagColectionVIew.dataSource = self
        tagColectionVIew.reload()

    }
    
    //MARK: API Methods
    func get_preferences(param:String)  {
        view.showProgress()
        callApi.callGetApi(apiFor: "get_preferences", parameters: param) { (response) in
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
                                        self.SearchArr = value["data"] as! [NSDictionary]
                                        print(self.SearchArr)
                                        
                                      //  self.PresentAlert(message:"Password Sent on Email.",title:"BMV")
                                       // self.interestArray.removeAll()
                                        self.interestArray = self.SearchArr 
//                                        for Dict in DetailArray as! [[String:Any]] {
//                                            let category = "\(Dict["CategoryName"] as! String)"
//                                            self.interestArray.append(category)
//                                        }
                                        self.TagConfiguration()
                                        //self.showAlrt(messageStr: "Registered Successfully")
                                        // self.showAlrt(messageStr: "Registered Successfully")
                                        
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
    
    func post_preferences(param:String)  {
            view.showProgress()
            callApi.callPostJsonApi(apiFor: "post_preferences", parameters: param) { (response) in
                                    print(response.result.value ?? "")
                                    if  response.result.isSuccess{
                                        let value = response.result.value as! [String:Any]
                                        print(value)
                                        let mess =  "\(String(describing: value["message"] ?? value["Message"]!))"
                                       // let status = value["status"] as! String
                                         self.view.dismissProgress()
                                       // self.PresentAlert(message:mess,title:"BMV")
                                        if mess == "success"{
                                           
//                                            let value = response.result.value as! [String:Any]
//                                            self.SearchArr = value["data"] as! [NSDictionary]
//                                            print(self.SearchArr)
                                            
                                                       let VC = self.storyboard?.instantiateViewController(withIdentifier: "TagsVC") as! TagsVC
                                                       self.navigationController?.pushViewController(VC, animated: true)
                                            
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
    
    func showAlrt(messageStr:String)
     {
         let alertController = UIAlertController(title: "BMV", message: messageStr, preferredStyle: UIAlertController.Style.alert)

         let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
                            print("OK")
                        }

                alertController.addAction(OkAction)
                self.present(alertController, animated: true, completion: nil)
     }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
        if selectedCategoryArray.count>0
        {

            var jsonArray = [NSDictionary]()
            for CategoryDict in selectedCategoryArray {
                let NewDict = ["Id": CategoryDict["CategoryId"]]
                jsonArray.append(NewDict as NSDictionary)
            }
            let Jsonstring = json(from: jsonArray)
           // Jsonstring = Jsonstring!.replacingOccurrences(of: "\"", with: "", options:NSString.CompareOptions.literal, range: nil)
 
            let userid = UserDefaults.standard.string(forKey: kUserId)
            let param = "userid=\(userid!)&postpreferences=\(Jsonstring!)"
            post_preferences(param: param)
           
//             let VC = self.storyboard?.instantiateViewController(withIdentifier: "TagsVC") as! TagsVC
//             self.navigationController?.pushViewController(VC, animated: true)
        }else{
            showAlrt(messageStr: "Please Select Category.")
        }
         
    }
    
    func json(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
}

extension PreferencesVC : TTGTagCollectionViewDelegate,TTGTagCollectionViewDataSource{

    
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
        let size = (interestArray[Int(index)]["CategoryName"] as! String).size(withAttributes:nil)
        let width = size.width + 40
        let height = size.height + 25
        return  CGSize(width: width, height: height)
    }
    func numberOfTags(in tagCollectionView: TTGTagCollectionView!) -> UInt {

            return UInt(interestArray.count)

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
        //vinay here-
        let selectedCategory = interestArray[taglabel.tag]
        if selectedCategoryArray.firstIndex(of: selectedCategory) != nil {
            taglabel.backgroundColor = UIColor(red:0.73, green:0.00, blue:0.00, alpha:1.0)
        }else{
            taglabel.backgroundColor = UIColor(red:0.99, green:0.94, blue:0.95, alpha:1.0)
        }
//            taglabel.backgroundColor = UIColor(red:0.99, green:0.94, blue:0.95, alpha:1.0)
            taglabel.text = (interestArray[Int(index)]["CategoryName"] as! String)
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
            let selectedCategory = interestArray[tagView.tag]
            if let index = selectedCategoryArray.firstIndex(of: selectedCategory) {
                selectedCategoryArray.remove(at: index)
            }
           // selectedCategoryArray.remove(at: tagView.tag)
        }
        else
        {
            tagView.backgroundColor = UIColor(red:0.73, green:0.00, blue:0.00, alpha:1.0)
            let selectedCategory = interestArray[tagView.tag]
             selectedCategoryArray.append(selectedCategory)
        }
        
        print(selectedCategoryArray,tagView.tag)
    }
    
    

//    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, updateContentSize contentSize: CGSize) {
//
//            feelingCvHeight = contentSize.height
//            feelingTtgCvHeight.constant = feelingCvHeight
//            MainViewHeight.constant = 572 + reasonCvHeight + feelingCvHeight + notesHeight
//
//    }
}

