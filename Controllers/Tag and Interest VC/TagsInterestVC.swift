//
//  TagsInterestVC.swift
//  BMV
//
//  Created by Silstone on 25/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import TTGTagCollectionView

class TagsInterestVC: UIViewController {


    var interestArray = [String]()
    @IBOutlet var tagColectionVIew: TTGTagCollectionView!
    var InterestTagViews: [UILabel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        interestArray = ["Interior","Exterior","Handicrafts","Footwear","Garden","Designing","Lorem Ipsum Interests"]
        TagConfiguration()
        // Do any additional setup after loading the view.
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
        tagColectionVIew.alignment = .fillByExpandingWidthExceptLastLine
        tagColectionVIew.horizontalSpacing = 10
        tagColectionVIew.verticalSpacing = 10
        self.tagColectionVIew.delegate = self
        self.tagColectionVIew.dataSource = self
        tagColectionVIew.reload()

    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
  */
     @IBAction func backBtnAction(_ sender: UIButton)
     {
        self.navigationController?.popViewController(animated: true)
     }
 
    
    @objc func btnCheck(_ sender: UIButton)
    {
        if !sender.isSelected
        {
            sender.isSelected = true
        }else
        {
            sender.isSelected = false
        }
    }
    @IBAction func doneBtnAction(_ sender: UIButton)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension TagsInterestVC : TTGTagCollectionViewDelegate,TTGTagCollectionViewDataSource{

    
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
        let size = (interestArray[Int(index)] as NSString).size(withAttributes:nil)
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
            taglabel.backgroundColor = UIColor(red:0.99, green:0.94, blue:0.95, alpha:1.0)
            taglabel.text = interestArray[Int(index)]
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
    
    

//    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, updateContentSize contentSize: CGSize) {
//        
//            feelingCvHeight = contentSize.height
//            feelingTtgCvHeight.constant = feelingCvHeight
//            MainViewHeight.constant = 572 + reasonCvHeight + feelingCvHeight + notesHeight
//   
//    }
}

extension TagsInterestVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interestArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "InterestCell"
        var cell: InterestCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? InterestCell
        if cell == nil {
            tableView.register(UINib(nibName: "InterestCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? InterestCell
        }
        cell.interestLable.text = interestArray[indexPath.row]
        cell.selectInterestBtn.addTarget(self, action: #selector(self.btnCheck(_:)), for: .touchUpInside)

        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 272
    //    }
}
