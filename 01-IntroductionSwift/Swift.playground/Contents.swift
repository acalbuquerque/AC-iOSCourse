//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var deposits = [450.0, 234.25, 300.0, 1200.0, 920.0, 23.0]
var withdraws = [22.0, 33.5, 450.0, 255.00, 430.0, 900, 21.75, 90.8, 100, 230.0]

func calculateDeposits() -> Double {
    var total = 0.0
    for deposit in deposits {
        total += deposit
    }
    return total
}

func calculateWithdraws() -> Double {
    var total = 0.0
    for withdraw in withdraws {
        total += withdraw
    }
    return total
}

func calculateBalance() {
    let accountBalance = calculateDeposits() - calculateWithdraws()
    print("\(accountBalance))")
}

calculateBalance()

deposits.append(300)
withdraws.append(100)

calculateBalance()

/*****************************************************************************/

enum TransactionType {
    case deposit
    case withdraw
}

let transactions:[(transaction:TransactionType, value: Double)] = [(.deposit, 200), (.withdraw, 100), (.deposit, 75.500000), (.deposit, 22.30), (.deposit, 10000.8)]

func calculateTransactionsBalance(){
    var total = 0.0
    for (transactionType, value) in transactions {
        total += transactionType == .deposit ? value : -value
    }
    print("\(total)")

    if total < 0 {
        print("Your balance is negative. See our loan options!")
    } else {
        switch total {
        case 0:
            print("Your account is empty")
        case 0..<10000:
            print("Do you want a new car or maybe a new house? Talk to us!")
        default:
            print("Best investment returns is here! Invest your money now!")
        }
    }

}

calculateTransactionsBalance()

/*************************************************************************/

enum Destinations:String {
    case USA = "United State"
    case Germany = "Germany"
    case Mexico = "Mexico"
    case Austria = "Austria"
    case Portugal = "Portugal"
    case China = "China"
    case Japan = "Japan"
    case Argentina = "Argentina"
    case Spain = "Spain"
    case Australia = "Australia"
}

class Passport {
    let number:String
    let isValid:Bool
    var visas:[Destinations]?

    init(passportNumber:String, isValid:Bool, visas:[Destinations]?) {
        self.number = passportNumber
        self.isValid = isValid
        self.visas = visas
    }
}

class Employee {
    let name:String
    let age:Int
    let passport:Passport?

    init(name:String, age:Int, passport:Passport?) {
        self.name = name
        self.age = age
        self.passport = passport
    }

    func travelAvailabity(destination:Destinations) {
        if let pport = self.passport {
            if pport.isValid {
                switch destination {
                case .USA, .Australia, .China, .Japan:
                    if let visas = pport.visas, visas.contains(destination) {
                        print("Unfortunately \(self.name) fulfills all required documentation and Visa to travel to \(destination.rawValue). Have a nice trip!")
                    } else {
                        print("Unfortunately \(self.name) doesn't have required Visa to travel to \(destination.rawValue)! Provide the Visa first.")
                    }
                default:
                    print("\(self.name) fulfills all required documentation to travel to \(destination.rawValue). Have a nice trip!")
                }
            } else {
                print("Unfortunately \(self.name) doesn't hold a valid Passport to travel to \(destination.rawValue). Provide a new one first.")
            }
        } else {
            print("Unfortunately \(self.name) doesn't hold a passport. Provide one first.")
        }
    }
}

let employee1 = Employee(name: "John Connor", age: 23, passport: Passport(passportNumber: "RD405933", isValid: true, visas: [.USA, .China]))
employee1.travelAvailabity(destination: .USA)
employee1.travelAvailabity(destination: .Australia)

let employee2 = Employee(name: "Vasco da Gama", age: 82, passport: nil)
employee2.travelAvailabity(destination: .USA)

let employee3 = Employee(name: "Capitão Nascimento", age: 34, passport: Passport(passportNumber: "CN394040", isValid: true, visas: nil))
employee3.travelAvailabity(destination: .USA)
employee3.travelAvailabity(destination: .Portugal)

/***************************************************************************/
