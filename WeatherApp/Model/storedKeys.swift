//
//  storedKeys.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 12/03/2024.
//

import Foundation

enum storedKeys: String{
    case baseURL = "https://api.weatherapi.com/v1/"
    case webKey = "0bc81aa0be414819a43163445240203"

    func value() -> String {
        return rawValue
    }
}
   
