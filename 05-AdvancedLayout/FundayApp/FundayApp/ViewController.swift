//
//  ViewController.swift
//  FundayApp
//
//  Created by Avenue Brazil on 26/09/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit
import Unbox
import NVActivityIndicatorView

class ViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var tableView: UITableView!
    var futureFundaysArray:[FutureFunday] = []
    var pastFundaysArray:[PastFunday] = []
    let dateFormatter = DateFormatter()
    let numberFormatter = NumberFormatter()

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()

        //self.dateFormatter.dateFormat = "yyy-MM-dd"
        self.numberFormatter.numberStyle = .ordinal

    }

    override func viewWillAppear(_ animated: Bool) {
        self.getEvents()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    func getEvents() {
        let endpoint = "http://demo8129738.mockable.io/fundays"
        dataTask?.cancel()
        self.startAnimating()

        if let url = URL(string: endpoint) {
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {

                    do {
                        let funday: FundaySchedule = try unbox(data: data)
                        DispatchQueue.main.async {
                            if let future = funday.futureFundays {
                                self.futureFundaysArray.removeAll()
                                self.futureFundaysArray.append(contentsOf: future)
                            }

                            if let past = funday.pastFundays {
                                self.pastFundaysArray.removeAll()
                                self.pastFundaysArray.append(contentsOf: past)
                            }

                            self.tableView.reloadData()
                        }
                    } catch {
                        print("An error occurred: \(error)")
                    }


                    DispatchQueue.main.async {
                        self.stopAnimating()
                    }
                    
                    print(response.debugDescription)
                    //self.updateSearchResults(data)

                }
            }
            dataTask?.resume()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getFormattedDateAndPlace(date:Date) -> String {
        return self.getFormattedDateAndPlace(date: date, place: nil)
    }

    func getFormattedDateAndPlace(date:Date, place:String?) -> String {
        var composedString:String
        self.dateFormatter.dateFormat = "MMMM"
        composedString = self.dateFormatter.string(from: date)

        self.dateFormatter.dateFormat = "dd"
        if let dayNumber = Int(self.dateFormatter.string(from: date)), let day = self.numberFormatter.string(from: NSNumber(value: dayNumber)) {
            composedString += " \(day)"
        }
        if let _place = place {
            composedString += " at \(_place)"
        }
        return composedString
    }
}

extension ViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return futureFundaysArray.count
        }
        return pastFundaysArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FundayCell"
        let cell:FundayTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FundayTableViewCell
        if indexPath.section == 0 {
            let funday = self.futureFundaysArray[indexPath.row]
            cell.eventNameLabel?.text = funday.title
            cell.dateAndPlaceLabel.text = self.getFormattedDateAndPlace(date: funday.date, place: funday.place.name)
        } else if indexPath.section == 1 {
            let funday = self.pastFundaysArray[indexPath.row]
            cell.eventNameLabel?.text = funday.title
            cell.dateAndPlaceLabel.text = self.getFormattedDateAndPlace(date: funday.date)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Future Events"
        }
        return "Past Events"
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController:FutureFundayDetailsViewController = storyboard.instantiateViewController(withIdentifier: "FutureFundayViewController") as! FutureFundayDetailsViewController
            viewController.funday = self.futureFundaysArray[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {

        }
    }
}
