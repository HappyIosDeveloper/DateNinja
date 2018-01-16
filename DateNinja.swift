//
//  DateNinja.swift
//  flightio
//
//  Created by GCO2(Ahmadreza) on 1/16/18.
//  Copyright © 2018 Alfredo Uzumaki. All rights reserved.
//

import UIKit

/*
 USAGE
 print(String(describing: toDateNinja("2017-10-20 15:40:00"))) // GMT
 
 CAUTION
 in case of failure, this date will be return => "1999-09-09 09:09:09"
 */

extension String {
    
    func replace(_ target: String, with: String) -> String {
        return self.replacingOccurrences(of: target, with: with, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeAfter(_ string: String)-> String {
        if let index = (self.range(of: string)?.lowerBound){
            return String(self.prefix(upTo: index))
        }
        return self
    }
    
    func resetTime()-> String {
        let a = self.removeAfter(" ")
        return a + " 00:00:00"
    }
    
    func toDateNinja(_ dateString: String, _ resetTime: Bool = false)-> Date {
        let stringWithoutPlus = dateString.removeAfter("+")
        let stringWithoutDot = stringWithoutPlus.removeAfter(".")
        var std = stringWithoutDot.replace("T", with:" ").replace("/", with: "-")
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss" // regular Date
        if resetTime {
            std = std.resetTime()
        }
        if let a:Date = dateFormatterGet.date(from: std) {
            return a
        }
        
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if var a:Date = dateFormatterGet.date(from: std) {
            if a.description != "" {
                if resetTime {
                    std = std.resetTime()
                    a = dateFormatterGet.date(from: std)!
                }
                return a
            } else {
                if resetTime {
                    std = std.resetTime()
                }
                dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss" // regular Date
                return dateFormatterGet.date(from: String(describing: std).removeAfter("+"))!
            }
        }
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        if resetTime {
            std = std.resetTime()
        }
        if let a:Date = dateFormatterGet.date(from: std) {
            dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss" // regular Date
            return dateFormatterGet.date(from: String(describing: a))!
        }
        dateFormatterGet.dateFormat = "yyyy-MM-dd H:mm:ss"
        if resetTime {
            std = std.resetTime()
        }
        if let a:Date = dateFormatterGet.date(from: std) {
            dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
            dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ssZ" // regular Date
            return dateFormatterGet.date(from: String(describing: a))!
        }
        print(" *********** ==> COULC NOT CONVERT THIS DATE: \(dateString) <== *********** ")
        dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatterGet.date(from: "1999-09-09 09:09:09" )! // default date! returns if none of above convers was successful
    }

}
