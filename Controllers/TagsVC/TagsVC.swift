//
//  TagsVC.swift
//  BMV
//
//  Created by Silstone on 05/11/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import TTGTagCollectionView
import iProgressHUD

class TagsVC: UIViewController {

    var callApi = HttpClientApi()
    @IBOutlet var categoryCollectionView: TTGTagCollectionView!
    @IBOutlet var tagCollectionView: TTGTagCollectionView!
   
    var categoryArray = [NSDictionary]()
    var tagsArray = [NSDictionary]()
    var InterestTagViews: [UILabel] = []
    var CategoryTagViews: [UILabel] = []
    var isFromTabBar: Bool = false
    @IBOutlet var doneBtn: UIButton!
    @IBOutlet var searchField: UITextField!
    var filtered = [NSDictionary]()
    var searchActive : Bool = false
    var SearchArr = [NSDictionary]()
    var selectedCategoryArray = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //tagsArray = ["Interior","Exterior","Handicrafts","Footwear","Garden","Designing","Lorem Ipsum Interests"]
    //categoryArray = ["Men's Clothing","Hats","Jeans","Woman's Clothing"]
   // TagConfiguration()
        // Do any additional setup after loading the view.
        iProgressHUD.sharedInstance().attachProgress(toView: self.view)
        
        if isFromTabBar == true {
            self.doneBtn.isHidden = false
        }
        
        let param = "userid=\(UserDefaults.standard.string(forKey: kUserId)!)"
        self.get_allTagPreferences(param: param)
        
        searchField.addTarget(self, action: #selector(PreferencesVC.textFieldDidChange(_:)),
        for: UIControl.Event.editingChanged)
    }
    
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
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
        tagCollectionView.reload()
       // categoryConfiguration()

    }
    
    func categoryConfiguration()  {
        let config = TTGTextTagConfig()
        config.shadowColor = hexStringToUIColor(hex: "#000000")
        // config.shadowColor = (hexStringToUIColor(hex: "#000000").cgColor)
        config.shadowRadius = 15.0
        //        config.shadowOpacity = CGPath(rect:  CGRect(x: 0, y:3, width: 0, height: 0), transform: nil)
        config.shadowOpacity = 0.16
        config.shadowOffset = CGSize(width: 0, height: 3)
        config.enableGradientBackground = true
        config.extraSpace = CGSize(width: 10, height: 10)
        config.selectedBackgroundColor = UIColor(red: 0.97, green: 0.64, blue: 0.27, alpha: 1.00)

        //feeling tag cv
        categoryCollectionView.alignment = .fillByExpandingWidthExceptLastLine
        categoryCollectionView.horizontalSpacing = 10
        categoryCollectionView.verticalSpacing = 10
        categoryCollectionView.showsHorizontalScrollIndicator = true
        categoryCollectionView.scrollDirection = .horizontal
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        categoryCollectionView.reload()
        //vinay here-
        TagConfiguration()
    }

    @objc func textFieldDidChange(_ textField: UITextField) {

     // filter tableViewData with textField.text
       print("interestArray",tagsArray)

        let searchText  = textField.text
        filtered = self.SearchArr.filter({
        let string = $0["tagname"] as! String

        return string.hasPrefix(searchText ?? "")
        })
        if(filtered.count == 0 && !(searchText != nil)){
            searchActive = false;
            tagsArray = self.SearchArr
        } else {
            searchActive = true;
            tagsArray = filtered
        }
        
        print(tagsArray)
        InterestTagViews.removeAll()
        self.tagCollectionView.delegate = self
        self.tagCollectionView.dataSource = self
        tagCollectionView.reload()
       

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
        func get_allTagPreferences(param:String)  {
            view.showProgress()
            callApi.callGetApi(apiFor: "get_allTagPreferences", parameters: param) { (response) in
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
                                            self.categoryArray  = value["data"] as! [NSDictionary]
                                            self.tagsArray = self.categoryArray[Int(0)]["tagarray"] as! [NSDictionary]
                                            self.SearchArr = self.tagsArray
                                            self.categoryConfiguration()
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
    
    func post_CategoryTag(paramsDict: NSDictionary,status:String)  {
                       // view.showProgress()
        view.showProgress()
        let param = "userid=\(UserDefaults.standard.string(forKey: kUserId)!)&categoryid=\(String(describing: paramsDict["CategoryId"]!))&tagname=\(String(describing: paramsDict["tagname"]!))&status=\(status)"
                       
                        callApi.callPostApi(apiFor: "post_categoryTags", parameters: param) { (response) in
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
                                }else
                                {
                                    self.showAlrt(messageStr: mess)
                                                   
                                }
                            }else{
    //                           // self.PresentAlert(message: "Could't connect to server", title: "BMV")
                                self.showAlrt(messageStr: "Could't connect to server.")
                                self.view.dismissProgress()
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
    @IBAction func backBtnAction(_ sender: UIButton)
     {
        self.navigationController?.popViewController(animated: true)
     }
    
    @IBAction func doneBtnAction(_ sender: UIButton)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func nextBtnAction(_ sender: UIButton) {
        
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "StoreNav") as! UINavigationController
                UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
}

//MARK: TTGTagCollectionView Extenstion delegate
extension TagsVC : TTGTagCollectionViewDelegate,TTGTagCollectionViewDataSource{


func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
   
    if tagCollectionView==categoryCollectionView {
       // let size = (categoryArray[Int(index)] as NSString).size(withAttributes:nil)
        //vinay here-
       let size = (categoryArray[Int(index)]["CategoryName"] as! String).size(withAttributes:nil)
           let width = size.width + 60
           let height = size.height + 30
        return  CGSize(width: width, height: height)
    }
   // let size = (tagsArray[Int(index)] as NSString).size(withAttributes:nil)
    //vinay here-
    let size = (tagsArray[Int(index)]["tagname"] as! String).size(withAttributes:nil)
       let width = size.width + 40
       let height = size.height + 25
    return  CGSize(width: width, height: height)
}
func numberOfTags(in tagCollectionView: TTGTagCollectionView!) -> UInt {

    if tagCollectionView==categoryCollectionView {
        return UInt(categoryArray.count)
    }
    return UInt(tagsArray.count)

}
func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, tagViewFor index: UInt) -> UIView! {
    
    
    if tagCollectionView==categoryCollectionView {
        
        let taglabel = UILabel()
        taglabel.tag = Int(index)
        CategoryTagViews.append(taglabel)
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
        //taglabel.text = categoryArray[Int(index)]
        //vinay here-
        taglabel.text = (categoryArray[Int(index)]["CategoryName"] as! String)
        taglabel.CornerRadius(21)
        return CategoryTagViews[Int(index)]
    }
    
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
        //taglabel.text = tagsArray[Int(index)]
    //vinay here-
    //vinay here-
    let selectedCategory = tagsArray[taglabel.tag]
    if selectedCategoryArray.firstIndex(of: selectedCategory) != nil {
        taglabel.backgroundColor = UIColor(red:0.73, green:0.00, blue:0.00, alpha:1.0)
    }else{
        taglabel.backgroundColor = UIColor(red:0.99, green:0.94, blue:0.95, alpha:1.0)
    }
    
    taglabel.text = (tagsArray[Int(index)]["tagname"] as! String)
        taglabel.CornerRadius(19)
        return InterestTagViews[Int(index)]

}

func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView?, didTapTag tagText: String?, at index: Int, selected: Bool, tagConfig config: TTGTextTagConfig?) {
    let stringTag = String(format: "Tap tag: %@, at: %ld, selected: %d", tagText ?? "", index, selected)
    print(stringTag)
}

func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, didSelectTag tagView: UIView!, at index: UInt) {
    
    if tagCollectionView==categoryCollectionView
    {
        tagView.backgroundColor = UIColor(red:0.73, green:0.00, blue:0.00, alpha:1.0)
        self.tagsArray = self.categoryArray[Int(index)]["tagarray"] as! [NSDictionary]
        self.SearchArr = self.tagsArray
        self.categoryConfiguration()
        
    }else{
        
        
        if tagView.backgroundColor == UIColor(red:0.73, green:0.00, blue:0.00, alpha:1.0)
        {
            tagView.backgroundColor = UIColor(red:0.99, green:0.94, blue:0.95, alpha:1.0)
            let selectedCategory = tagsArray[tagView.tag]
            if let index = selectedCategoryArray.firstIndex(of: selectedCategory) {
                selectedCategoryArray.remove(at: index)
                post_CategoryTag(paramsDict: selectedCategory, status: "unselected")
            }
        }
        else
        {
            tagView.backgroundColor = UIColor(red:0.73, green:0.00, blue:0.00, alpha:1.0)
            let selectedCategory = tagsArray[tagView.tag]
            selectedCategoryArray.append(selectedCategory)
            post_CategoryTag(paramsDict: selectedCategory, status: "selected")
        }
    }
 
}
}
