//
//  Funday.swift
//  FundayApp
//
//  Created by Avenue Brazil on 26/09/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit
import Unbox

struct FundaySchedule {
    let futureFundays:[FutureFunday]?
    let pastFundays:[PastFunday]?
}

extension FundaySchedule: Unboxable {
    init(unboxer: Unboxer) throws {
        self.futureFundays = unboxer.unbox(key: "future")
        self.pastFundays = unboxer.unbox(key: "past")
    }
}

struct FutureFunday {
    let title: String
    let date: Date
    let eventDescription: String
    let details: String
    let place: Place
    let food:[String]
}

extension FutureFunday: Unboxable {
    init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(key: "title")
        self.eventDescription = try unboxer.unbox(key: "description")
        self.details = try unboxer.unbox(key: "details")
        self.place = try unboxer.unbox(key: "place")
        self.food = try unboxer.unbox(key: "food")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.date = try unboxer.unbox(key: "date", formatter: dateFormatter)
    }
}

struct PastFunday {
    let title: String
    let date: Date
    let eventDescription: String
    let photos: [String]?
}

extension PastFunday: Unboxable {
    init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(key: "title")
        self.eventDescription = try unboxer.unbox(key: "description")
        self.photos = unboxer.unbox(key: "photos")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        self.date = try unboxer.unbox(key: "date", formatter: dateFormatter)
    }
}

struct Place {
    let name: String
    let latitude: Double
    let longitude: Double
}

extension Place: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.latitude = try unboxer.unbox(key: "latitude")
        self.longitude = try unboxer.unbox(key: "longitude")
    }
}
