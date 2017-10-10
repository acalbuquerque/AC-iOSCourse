//
//  ConfirmationViewController.swift
//  SimpleCheckoutApp
//
//  Created by Avenue Brazil on 25/09/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    var totalPrice: Double?
    @IBOutlet weak var merchandiseLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.merchandiseLabel.text = String(format: "$%.2f", self.totalPrice ?? 0)
        self.navigationItem.hidesBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
