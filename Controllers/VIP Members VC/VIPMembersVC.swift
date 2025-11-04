//
//  VIPMembersVC.swift
//  BMV
//
//  Created by Silstone on 03/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class VIPMembersVC: UIViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "VipCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VipCollectionViewCell")
       
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VipCollectionViewCell", for: indexPath) as! VipCollectionViewCell
        
        cell.btnThanks.addTarget(self, action: #selector(ThanksButtonTapped), for: UIControl.Event.touchUpInside)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 294, height: 425)
        
    }
    
    @IBAction func ThanksButtonTapped() -> Void {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "StoreProductsVC") as! StoreProductsVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
