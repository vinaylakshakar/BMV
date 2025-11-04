//
//  EditPreferencesVC.swift
//  BMV
//
//  Created by Silstone on 26/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class EditPreferencesVC: UIViewController {
    
    @IBOutlet var categoryCollectionView: TTGTagCollectionView!
    var categoryArray = [String]()
    var CategoryTagViews: [UILabel] = []
    
    override func viewDidLoad() {
        categoryArray = ["Men's Clothing","Hats","Jeans","Woman's Clothing"]
        categoryConfiguration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    
     // MARK: - CreateCategoryTags
    
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
    //        categoryCollectionView.scrollDirection = .horizontal
            self.categoryCollectionView.delegate = self
            self.categoryCollectionView.dataSource = self
            categoryCollectionView.reload()

        }
    
    @IBAction func donePreferenceAction(_ sender: UIButton)
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "TagsVC") as! TagsVC
        VC.isFromTabBar = true
        self.navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func profileBtnAction(_ sender: UIButton)
    {
        self.tabBarController?.selectedIndex = 0
    }
    
    
}

//MARK: TTGTagCollectionView Extenstion delegate
extension EditPreferencesVC : TTGTagCollectionViewDelegate,TTGTagCollectionViewDataSource{


func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
   
    let size = (categoryArray[Int(index)] as NSString).size(withAttributes:nil)
              let width = size.width + 60
              let height = size.height + 30
           return  CGSize(width: width, height: height)
    
}
func numberOfTags(in tagCollectionView: TTGTagCollectionView!) -> UInt {

    return UInt(categoryArray.count)

}
func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, tagViewFor index: UInt) -> UIView! {
    
    
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
           taglabel.text = categoryArray[Int(index)]
           taglabel.CornerRadius(21)
           return CategoryTagViews[Int(index)]

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
