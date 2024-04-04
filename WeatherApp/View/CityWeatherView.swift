//
//  ContentView.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 03/03/2024.
//

import SwiftUI

struct CityWeatherView: View {
    
    var weatherForcast: WeatherForeCastResponseModel?
    
    var body: some View {
        
        ScrollView {
            VStack {
                
                WeatherSummeryView(weatherForcast: weatherForcast)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 50)
                    .padding(.bottom, 30)
                
                let forcastday = weatherForcast?.forecast?.forecastday
                DailyWeatherView(foreCast: forcastday?.first?.hour )
                    .padding(14)
                
                WeeklyWeatherView(foreCast: forcastday)
                    .padding(14)
            }
        }
        .padding(.bottom, 50)
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    
    CityWeatherView()
    
}
