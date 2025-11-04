//
//  BookmarksVC.swift
//  BMV
//
//  Created by Silstone on 27/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class BookmarksVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "ResultsViewCell", bundle: nil), forCellWithReuseIdentifier: "ResultsViewCell")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func profileBtnAction(_ sender: UIButton)
    {
        self.tabBarController?.selectedIndex = 0
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

}

extension BookmarksVC:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultsViewCell", for: indexPath) as! ResultsViewCell
        //cell.starImage.image = UIImage(named: "favourite-select")!
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
        return CGSize(width: collectionView.bounds.size.width/2-10, height: 239)
    }
}
