//
//  WeatherAppUseCase.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 04/03/2024.
//

import Foundation


protocol WeatherAppUseCaseProtocol
{
    func getCurrentWeather(for city: String, result: @escaping((Result<WeatherForeCastResponseModel, APIService.APIError>) -> ()))
}


class WeatherAppUseCase: WeatherAppUseCaseProtocol {
    
    func getCurrentWeather(for city: String, result: @escaping((Result<WeatherForeCastResponseModel, APIService.APIError>) -> ())){
        
        
        let apiService = APIService.shared
        apiService.getJSON(urlString: "\(storedKeys.baseURL.value())forecast.json?key=\(storedKeys.webKey.value())&q=\(city)&days=7&aqi=no&alerts=no") {
            
            
            (response: Result<WeatherForeCastResponseModel, APIService.APIError>) in
            
            switch response {
                
            case .success(let forecast):
                print(forecast)
                result(.success(forecast))
                
            case .failure(let apiError):
                result(.failure(apiError))
            }
        }
    }
    
}
