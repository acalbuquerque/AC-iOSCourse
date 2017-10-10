//
//  FundayTableViewCell.swift
//  FundayApp
//
//  Created by Avenue Brazil on 27/09/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit

class FundayTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateAndPlaceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
