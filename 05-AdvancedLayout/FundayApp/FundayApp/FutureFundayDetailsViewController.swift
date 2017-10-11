//
//  FutureFundayDetailsViewController.swift
//  FundayApp
//
//  Created by Avenue Brazil on 02/10/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit
import MapKit

class FutureFundayDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var funday:FutureFunday?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Future Funday"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FutureFundayDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 || section == 1 ? 1 : (self.funday?.food.count ?? 0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cellIdentifier = "FutureFundayDetailedTableViewCell"
            let cell:FutureFundayDetailedInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FutureFundayDetailedInfoTableViewCell
            if let _funday = self.funday {
                cell.fundayNameLabel.text = _funday.title
                cell.fundayDetailsLabel.text = _funday.details
                cell.fundayDescriptionLabel.text = _funday.eventDescription

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                cell.dateAndPlaceLabel.text = dateFormatter.string(from: _funday.date)

//                let point = MKPointAnnotation()
//                point.coordinate = CLLocationCoordinate2DMake(_funday.place.latitude, _funday.place.longitude)
//                point.title = _funday.place.name
//                cell.mapView.addAnnotation(point)
//
//                cell.mapView.setRegion(MKCoordinateRegionMakeWithDistance(point.coordinate, 500, 500), animated: false)
            }
            return cell
        case 1:
            let cellIdentifier = "FutureFundayLocationTableViewCell"
            let cell:FutureFundayLocationTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FutureFundayLocationTableViewCell
            if let _funday = self.funday {
                let point = MKPointAnnotation()
                point.coordinate = CLLocationCoordinate2DMake(_funday.place.latitude, _funday.place.longitude)
                point.title = _funday.place.name
                cell.mapView.addAnnotation(point)
                cell.mapView.setRegion(MKCoordinateRegionMakeWithDistance(point.coordinate, 500, 500), animated: false)
                cell.locationNameLabel.text = _funday.place.name
            }
            return cell
        default:
            let cellIdentifier = "FutureFundayFoodTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FundayFoodTableViewCell
            cell.foodNameLabel.text = self.funday?.food[indexPath.row] ?? ""
            return cell
        }


//        if indexPath.section == 0 {
//            let cellIdentifier = "FutureFundayDetailedTableViewCell"
//            let cell:FutureFundayDetailedInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FutureFundayDetailedInfoTableViewCell
//            if let _funday = self.funday {
//                cell.fundayNameLabel.text = _funday.title
//                cell.fundayDetailsLabel.text = _funday.details
//                cell.fundayDescriptionLabel.text = _funday.eventDescription
//
//                let point = MKPointAnnotation()
//                point.coordinate = CLLocationCoordinate2DMake(_funday.place.latitude, _funday.place.longitude)
//                point.title = _funday.place.name
//                cell.mapView.addAnnotation(point)
//
//                cell.mapView.setRegion(MKCoordinateRegionMakeWithDistance(point.coordinate, 500, 500), animated: false)
//            }
//            return cell
//        } else {
//            let cellIdentifier = "FutureFundayFoodTableViewCell"
//            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FundayFoodTableViewCell
//            cell.foodNameLabel.text = self.funday?.food[indexPath.row] ?? ""
//            return cell
//        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Location"
        default:
            return "Food Menu"
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 388
        }
        return 48
    }
}
