//
//  FutureFundayDetailedInfoTableViewCell.swift
//  FundayApp
//
//  Created by Avenue Brazil on 02/10/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit

class FutureFundayDetailedInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var fundayNameLabel: UILabel!
    @IBOutlet weak var dateAndPlaceLabel: UILabel!
    @IBOutlet weak var containerFundayDescriptionView: UIView!
    @IBOutlet weak var fundayDescriptionLabel: UILabel!
    @IBOutlet weak var fundayDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerFundayDescriptionView.layer.borderColor = UIColor(displayP3Red: 0.7, green: 0.7, blue: 0.7, alpha: 1).cgColor
        self.containerFundayDescriptionView.layer.borderWidth = 1
        self.containerFundayDescriptionView.layer.cornerRadius = 6
        self.containerFundayDescriptionView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
