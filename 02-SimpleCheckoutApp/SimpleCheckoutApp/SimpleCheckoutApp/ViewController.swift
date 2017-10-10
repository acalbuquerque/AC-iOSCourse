//
//  ViewController.swift
//  SimpleCheckoutApp
//
//  Created by Avenue Brazil on 25/09/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!

    let price = 24.90
    var qty = 1

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        qty = 1
        self.updateQuantityInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func increaseQuantity(_ sender: Any) {
        self.qty += 1
        self.updateQuantityInformation()
    }

    @IBAction func decreaseQuantity(_ sender: Any) {
        if self.qty > 1 {
            self.qty -= 1
            self.updateQuantityInformation()
        }
    }

    func updateQuantityInformation() {
        self.quantityLabel.text = "Qty: \(self.qty)"
        let updatedPrice = Double(self.qty) * self.price
        let formattedPrice = String(format: "%.2f", updatedPrice)
        self.totalPriceLabel.text = "Total: \(formattedPrice)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.destination is ConfirmationViewController {
            if let viewController = segue.destination as? ConfirmationViewController {
                viewController.totalPrice = Double(self.qty) * self.price
            }
        }
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }

}

