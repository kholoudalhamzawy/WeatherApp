//
//  WeatherForCastsManeger.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 12/03/2024.
//

import Foundation
import SwiftUI

class WeatherForCastsManeger {
    
    static func setAppTheme(_ isDay: Int){
        Color.currentTheme = isDay == 0 ? .night : .day

    }

    
    static func extractTime(from dateTimeString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let date = dateFormatter.date(from: dateTimeString) {

            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: date)
            
            return calendar.date(bySettingHour: components.hour ?? 0, minute: components.minute ?? 0, second: 0, of: Date())
        } else {
            return nil
        }
    }
    
    static func formattedTime(from date: String) -> String {
        let time = extractTime(from: date) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: time)
    }
    
    
    static func formattedHour(from date: String) -> String {
        let time = extractTime(from: date) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        return dateFormatter.string(from: time)
    }
    
    
    static func sortWeatherForcastTime(_ weatherForeCast:[Hour]) -> [Hour] {
        let currentHour = Calendar.current.component(.hour, from: Date())

        var sortedTimeForcat = weatherForeCast
        sortedTimeForcat.sort { (hourString1: Hour, hourString2: Hour) -> Bool in
            guard let date1 = extractTime(from: hourString1.time ?? ""),
                  let date2 = extractTime(from: hourString2.time ?? "") else{
                return false
            }
            
            let hour1 = Calendar.current.component(.hour, from: date1)
            let hour2 = Calendar.current.component(.hour, from: date2)
            
            let adjustedHour1 = (hour1 - currentHour + 24) % 24
            let adjustedHour2 = (hour2 - currentHour + 24) % 24
            
            return adjustedHour1 < adjustedHour2
        }
        return sortedTimeForcat
    }
    
    
    static func extractDay(from dateTimeString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: dateTimeString) {
            
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEE"
            let day = dayFormatter.string(from: date)
            return day
        } else {
            return nil
        }
    }

    
}
