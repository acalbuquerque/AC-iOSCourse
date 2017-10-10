//
//  Funday.swift
//  FundayApp
//
//  Created by Avenue Brazil on 26/09/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit

class Funday: NSObject {
    var title: String?
    var date: Date?
    var eventDescription: String?
    var details: String?
    var place: Place?
    var food:[String]?
}

class Place: NSObject {
    var name: String?
    var latitude: Double?
    var longitude: Double?
}
