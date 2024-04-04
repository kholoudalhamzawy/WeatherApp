//
//  WeatherIcons.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 03/03/2024.
//
import Foundation

// MARK: - WeatherIcons
class WeatherIcons: Codable {
    let code: Int
    let day, night: String
    let icon: Int
    static let icons: [WeatherIcons] =  Bundle.main.decode(file: "weather_conditions.json")


    init(code: Int = 0, day: String = "", night: String = "", icon: Int = 0) {
        self.code = code
        self.day = day
        self.night = night
        self.icon = icon

    }
}

// Extension to decode JSON locally
extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}
