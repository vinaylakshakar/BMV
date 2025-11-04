//
//  CustomerReservedItemVC.swift
//  BMV
//
//  Created by Silstone on 11/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import MGStarRatingView

class CustomerReservedItemVC: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,StarRatingDelegate {


    @IBOutlet var navigationVIew: UIView!
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "ReservedCell", bundle: nil), forCellWithReuseIdentifier: "ReservedCell")
        // Do any additional setup after loading the view.
        dropShadow(shadowView: navigationVIew)

    }
    
    func showRating(ratingView: StarRatingView)
    {
        let attribute = StarRatingAttribute(type: .rate, point: 18,
                                            spacing: 6,
                                            emptyColor: UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0),
                                            fillColor: UIColor(red:0.97, green:0.74, blue:0.18, alpha:1.0),
                                            emptyImage: nil,
                                            fillImage: nil)
        ratingView.configure(attribute, current: 4, max: 5)
        ratingView.delegate = self
    }
    
    func dropShadow(scale: Bool = true, shadowView:UIView) {
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: shadowView.bounds.origin.x, y: shadowView.frame.size.height))
        shadowPath.addLine(to: CGPoint(x: shadowView.bounds.width / 2, y: shadowView.bounds.height + 7.0))
        shadowPath.addLine(to: CGPoint(x: shadowView.bounds.width, y: shadowView.bounds.height))
        shadowPath.close()
        
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOpacity = 5
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowPath = shadowPath.cgPath
        shadowView.layer.shadowRadius = 2
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func StarRatingValueChanged(view: StarRatingView, value: CGFloat) {
        print("rating changed")
    }
    
    @objc func addReserveActin(sender: UIButton){
        let buttonTag = sender.tag
        print(buttonTag)
        if !sender.isSelected
        {
            sender.isSelected = true
        }else
        {
            sender.isSelected = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReservedCell", for: indexPath) as! ReservedCell
        cell.addReserveBtn.tag = indexPath.row
        
        if indexPath.row>1
        {
            cell.addReserveBtn.isSelected = true
            cell.itemPricelbl.text = "25% OFF"
            cell.itemDiscountlbl.text = "New"
            cell.itemImage.image = UIImage(named: "Layer 3")!
        }
        
        cell.addReserveBtn.addTarget(self, action: #selector(addReserveActin(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if UIDevice.current.iPhone5s {
            print("This device is a iPhone5s")
            return CGSize(width: collectionView.bounds.size.width/2-10, height: 170)
        }
        return CGSize(width: collectionView.bounds.size.width/2-10, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CustomerInfoIdentifier", for: indexPath) as! CustomerInfoReusableView
            // Customize headerView here
             dropShadow(shadowView: headerView.profileView)
                       let attribute = StarRatingAttribute(type: .rate, point: 18,
                                                            spacing: 6,
                                                            emptyColor: UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0),
                                                           fillColor: UIColor(red:0.97, green:0.74, blue:0.18, alpha:1.0),
                                                            emptyImage: nil,
                                                            fillImage: nil)
                        headerView.starRating.configure(attribute, current: 4, max: 5)
                        headerView.starRating.delegate = self
            
            return headerView
        }
        fatalError()
    }

}

