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

class ViewController: UIViewController, UITableViewDelegate, NVActivityIndicatorViewable {

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

//        let place1 = Place()
//        place1.name = "Quintal do Chalé"
//
//        let place2 = Place()
//        place2.name = "Avenue Code"
//
//        let place3 = Place()
//        place3.name = "Caçapa's Bar"
//
//        let funday1 = Funday()
//        funday1.title = "Christmas Party"
//        funday1.eventDescription = "Let's celebrate the end of one more year in a Christmas party. Everybody must be dressed using white clothes."
//        funday1.date = self.dateFormatter.date(from: "2017-12-20")
//        funday1.place = place1
//        self.futureFundaysArray.append(funday1)
//
//        let funday2 = Funday()
//        funday2.title = "Carnival Extravaganza"
//        funday2.eventDescription = "The best brazilian party will be celebrated by."
//        funday2.date = self.dateFormatter.date(from: "2018-03-21")
//        funday2.place = place2
//        self.futureFundaysArray.append(funday2)
//
//        let funday3 = Funday()
//        funday3.title = "Pool Championship"
//        funday3.eventDescription = "Avenue Code invites everybody to a pool championship at Caçapas bar. As prize with offer an Avenue Code jacket."
//        funday3.date = self.dateFormatter.date(from: "2018-09-28")
//        funday3.place = place3
//        self.futureFundaysArray.append(funday3)
//
//        let funday4 = Funday()
//        funday4.title = "Anarriê Anarriê"
//        funday4.eventDescription = "Everybody is invited to this tradional brazilian party: Festa Junina."
//        funday4.date = self.dateFormatter.date(from: "2017-08-06")
//        funday4.place = place2
//        self.pastFundaysArray.append(funday4)

    }

    override func viewWillAppear(_ animated: Bool) {
        self.getEvents()
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
                                self.futureFundaysArray.append(contentsOf: future)
                            }

                            if let past = funday.pastFundays {
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
        return 75
    }
}
