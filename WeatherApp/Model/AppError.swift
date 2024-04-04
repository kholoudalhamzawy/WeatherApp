//
//  AppError.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 12/03/2024.
//

import Foundation

struct AppError: Identifiable {
    let id = UUID().uuidString
    let errorString: String
}
