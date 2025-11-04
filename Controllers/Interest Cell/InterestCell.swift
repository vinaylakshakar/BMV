//
//  InterestCell.swift
//  BMV
//
//  Created by Silstone on 25/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class InterestCell: UITableViewCell {

    @IBOutlet var selectInterestBtn: UIButton!
    @IBOutlet var interestLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
