//
//  HeartStoreMemberProfileVC.swift
//  BMV
//
//  Created by Silstone on 02/10/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit
import PieCharts

class HeartStoreMemberProfileVC: UIViewController,PieChartDelegate{

    

    @IBOutlet var activityViewContainer: UIView!
    @IBOutlet var infoViewContainer: UIView!
    @IBOutlet weak var ChartView: PieChart!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.activityViewContainer.isHidden = true
        self.infoViewContainer.isHidden = false
        showPieChart()
    }
    
    func showPieChart() {
        
        var complteness = NSNumber()
        var incomplete = NSNumber()
        complteness = 75
        incomplete = NSNumber(value: 100 - Int(truncating: complteness))
        self.ChartView.models = [
            //Moving
            // PieSliceModel(value: Double(truncating: Moving), color: hexStringToUIColor(hex: "#3CB424")),
            PieSliceModel(value: Double(truncating: complteness), color:  hexStringToUIColor(hex: "#BA0000"), obj: "complteness"),
            PieSliceModel(value: Double(truncating: incomplete), color:  hexStringToUIColor(hex: "#E0E0E0"), obj: "incomplete")
            
        ]
    }
    func onSelected(slice: PieSlice, selected: Bool) {
        print("selected")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func activityBtnAction(_ sender: UIButton)
    {
        self.activityViewContainer.isHidden = false
        self.infoViewContainer.isHidden = true
    }
    @IBAction func infoBtnAction(_ sender: UIButton)
    {
        self.activityViewContainer.isHidden = true
        self.infoViewContainer.isHidden = false
    }
    
}
