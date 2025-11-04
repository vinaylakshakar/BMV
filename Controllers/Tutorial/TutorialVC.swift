//
//  TutorialVC.swift
//  BMV
//
//  Created by Silstone on 09/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class TutorialVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var view0: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet var topspaceConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.iPhoneXR {
            print("This device is a iPhoneXR")
            topspaceConstant.constant = 65
        }
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        if pageNumber == 0{
            view0.backgroundColor = hexStringToUIColor(hex: "#FEB137")
            view1.backgroundColor = hexStringToUIColor(hex: "#CCD3DC")
            view2.backgroundColor = hexStringToUIColor(hex: "#CCD3DC")
        }else if pageNumber == 1{
            view0.backgroundColor = hexStringToUIColor(hex: "#CCD3DC")
            view1.backgroundColor = hexStringToUIColor(hex: "#FEB137")
            view2.backgroundColor = hexStringToUIColor(hex: "#CCD3DC")
        }else{
            view0.backgroundColor = hexStringToUIColor(hex: "#CCD3DC")
            view1.backgroundColor = hexStringToUIColor(hex: "#CCD3DC")
            view2.backgroundColor = hexStringToUIColor(hex: "#FEB137")
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

    //MARK:DATASOURCE
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCell", for: indexPath) as! TutorialCell
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
    
    @IBAction func nextBtnAction(_ sender: UIButton)
    {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "PreferencesVC") as! PreferencesVC
        self.navigationController?.pushViewController(VC, animated: true)
        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "deashboardNav") as! UINavigationController
//        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    
    
}
extension UIDevice {
    var iPhoneXR: Bool {
        return UIScreen.main.nativeBounds.height >= 1792
    }
}
