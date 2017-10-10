//
//  FutureFundayLocationTableViewCell.swift
//  FundayApp
//
//  Created by Avenue Brazil on 03/10/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit
import MapKit

class FutureFundayLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.blurView.layer.cornerRadius = 6
        self.blurView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
