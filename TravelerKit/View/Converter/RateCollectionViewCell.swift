//
//  RateCollectionViewCell.swift
//  P9
//
//  Created by De knyf Gregory on 12/06/18.
//  Copyright © 2018 De knyf Gregory. All rights reserved.
//

import UIKit

class RateCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var rateLabel: UILabel!

    override var isSelected: Bool{
        didSet {
            if isSelected {
                self.rateLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            } else {
                self.rateLabel.backgroundColor = .none
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.isSelected = false
    }
}
