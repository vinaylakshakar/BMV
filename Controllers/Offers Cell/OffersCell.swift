//
//  OffersCell.swift
//  BMV
//
//  Created by Silstone on 16/09/19.
//  Copyright © 2019 Silstone. All rights reserved.
//

import UIKit

class OffersCell: UICollectionViewCell {

    @IBOutlet var offerPrice: UILabel!
    @IBOutlet var offerType: UILabel!
    @IBOutlet var offerImage: UIImageView!
    @IBOutlet var bookmarkImage: UIImageView!
    @IBOutlet var btnBookmark: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
