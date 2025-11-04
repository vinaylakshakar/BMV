//
//  CustomerSaleVC.swift
//  BMV
//
//  Created by Silstone on 09/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import MGStarRatingView

class CustomerSaleVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,StarRatingDelegate {
  
    @IBOutlet var navigationVIew: UIView!
    @IBOutlet var profileView: UIView!
    @IBOutlet var starRating: StarRatingView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "CustomerSaleViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomerSaleViewCell")
        showRating(ratingView: starRating)
        dropShadow(shadowView: profileView)
        dropShadow(shadowView: navigationVIew)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        if pageNumber == 0{
            pageControl.currentPage = 0
        }else if pageNumber == 1{
            pageControl.currentPage = 1
        }else if pageNumber == 2{
            pageControl.currentPage = 2
        }else if pageNumber == 3{
            pageControl.currentPage = 3
        }else if pageNumber == 4{
            pageControl.currentPage = 4
        }else if pageNumber == 5{
            pageControl.currentPage = 5
        }
    }
    
    func StarRatingValueChanged(view: StarRatingView, value: CGFloat) {
        print("rating changed")
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
    
    //MARK:DATASOURCE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerSaleViewCell", for: indexPath) as! CustomerSaleViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
