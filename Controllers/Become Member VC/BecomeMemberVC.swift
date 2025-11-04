//
//  BecomeMemberVC.swift
//  BMV
//
//  Created by Silstone on 23/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class BecomeMemberVC: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
@IBOutlet var collectionView: UICollectionView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         collectionView.register(UINib(nibName: "OffersCell", bundle: nil), forCellWithReuseIdentifier: "OffersCell")
         categoryCollectionView.register(UINib(nibName: "CategoryOfferCell", bundle: nil), forCellWithReuseIdentifier: "CategoryOfferCell")
        // Do any additional setup after loading the view.
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView==categoryCollectionView
        {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryOfferCell", for: indexPath) as! CategoryOfferCell
            return cell
        }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OffersCell", for: indexPath) as! OffersCell
            
             return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView==categoryCollectionView
        {
            if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height >= 2436 {
                //iPhone X
                return CGSize(width: view.bounds.size.width/2-40, height: 164)
            }
          return CGSize(width: view.bounds.size.width/2-15, height: 164)
        }
        return CGSize(width: view.bounds.size.width/2-10, height: 200)

    }

}
