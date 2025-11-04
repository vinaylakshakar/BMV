//
//  CustomerSaleDetailVC.swift
//  BMV
//
//  Created by Silstone on 10/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class CustomerSaleDetailVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "CustomerSaleViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomerSaleViewCell")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 6
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomerSaleViewCell", for: indexPath) as! CustomerSaleViewCell
        
        cell.itemNamelbl.isHidden = true
        cell.itemPricelbl.isHidden = true
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
