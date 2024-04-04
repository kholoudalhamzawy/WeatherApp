//
//  WeatherAppViewModel.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 04/03/2024.
//

import Foundation
import SwiftUI


class WeatherAppViewModel: ObservableObject {
    
    @Published var forecasts: [WeatherForeCastResponseModel] = []
    private var localForecasts: [WeatherForeCastResponseModel] = []
    
    @Published var location: String = ""
    @Published var appError: AppError? = nil
    @Published var isLoading: Bool = false
    private var storedLocations: [String] = []
    
    private var userDefaults = UserDefaults.standard
    private var useCase: WeatherAppUseCaseProtocol = WeatherAppUseCase()
    
    
    init() {
        getStoredWeatherForecast()
    }
    
    func getWeatherForecast() {
        
        
        UIApplication.shared.endEditing()
        
        if checkLocationValdity()  {
            isLoading = true
            
            DispatchQueue.global(qos: .userInitiated).async() { [weak self] in
                
                self?.useCase.getCurrentWeather(for: self?.location ?? "") { [weak self] result in
                    
                    switch result {
                    case .success(let forecast):
                        self?.isLoading = false
                        if forecast.location != nil {
                            
                            self?.addWeatherForCast(forecast: forecast)
                            self?.addLocation(self?.location ?? "")
                            
                            self?.updateForCasts()
                        
                        } else {
                            self?.appError = AppError(errorString: "Location Couldn't Be Found.")
                            
                        }
                        self?.location = ""
                        
                        
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            self?.isLoading = false
                            self?.location = ""
                            self?.appError = AppError(errorString: errorString)
                        }
                        
                    }
                }
            }
        }
    }
    
    func checkLocationValdity() -> Bool{
        if !self.location.isEmpty, !self.storedLocations.contains(self.location) {
            
            return true
        }
        return false
    }
    
    
    
    
    private let concurrentWeatherQueue =
    DispatchQueue(
        label: "WeatherApiQueue",
        attributes: .concurrent)
    
    func getStoredWeatherForecast() {
        isLoading = true
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            self?.storedLocations = self?.getLocations() ?? []
            
            let downloadGroup = DispatchGroup()
            
            for locationIndex in 0..<(self?.storedLocations.count ?? 0)  {
                
                downloadGroup.enter()
                self?.useCase.getCurrentWeather(for: self?.storedLocations[locationIndex] ?? "") { [weak self] result in
                    
                    switch result {
                    case .success(let forecast):
                        self?.addWeatherForCast(forecast: forecast)
                        
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            self?.appError = AppError(errorString: errorString)
                        }
                    }
                    downloadGroup.leave()
                    
                }
                
            }

            downloadGroup.notify(queue: DispatchQueue.main) {
                self?.isLoading = false
                self?.forecasts =  self?.getWeatherForCasts() ?? []
                WeatherForCastsManeger.setAppTheme(self?.forecasts.first?.current?.is_day ?? 0)
            }
            
            
        }
        
    }
    
    func addLocation(_ location: String){

        concurrentWeatherQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else {
                return
            }
            self.storedLocations.append(location)
            self.userDefaults.set(self.storedLocations, forKey: "locations")
            
        }
        
    }
    func getLocations() -> [String]{
        
        var locationsCopy: [String] = []
        concurrentWeatherQueue.sync {
            locationsCopy = userDefaults.object(forKey: "locations") as? [String] ?? []
        }
        
        return locationsCopy
        
    }
    
    func addWeatherForCast(forecast: WeatherForeCastResponseModel){
        
        concurrentWeatherQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else {
                return
            }
            self.localForecasts.append(forecast)
        }
       
    }
    func getWeatherForCasts() -> [WeatherForeCastResponseModel]{
        var forcastCopy: [WeatherForeCastResponseModel] = []
        
        concurrentWeatherQueue.sync {
            
            forcastCopy = localForecasts
            
        }
        return forcastCopy
        
    }
    
    func updateForCasts(){
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            self?.forecasts =  self?.getWeatherForCasts() ?? []
            WeatherForCastsManeger.setAppTheme(self?.forecasts.first?.current?.is_day ?? 0)
            
        }
    }
   
    
    
}




