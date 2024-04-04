//
//  WeatherSummeryView.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 03/03/2024.
//

import SwiftUI

struct WeatherSummeryView: View {
    
    var weatherForcast: WeatherForeCastResponseModel?
    
    var body: some View {
        VStack{
            Text(weatherForcast?.location?.name ?? "")
                .font(Font.system(size: 32))
                .foregroundColor(.white)
                .shadow(radius: 2.0)
            
            Text(" \(weatherForcast?.current?.temp_c ?? 0.0, specifier: "%.0f")°")
                .font(Font.system(size: 100))
                .fontWeight(.thin)
                .foregroundColor(.white)
                .shadow(radius: 2.0)
            
            Text(weatherForcast?.current?.condition?.text ?? "")
                .font(Font.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(.white)
                .shadow(radius: 2.0)
            
            Text("H:\(weatherForcast?.forecast?.forecastday?[0].day?.maxtemp_c ?? 0.0, specifier: "%.0f")° L:\(weatherForcast?.forecast?.forecastday?[0].day?.mintemp_c ?? 0.0, specifier: "%.0f")°")
                .font(Font.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(.white)
                .shadow(radius: 2.0)
        }
    }
}

#Preview {
    ScrollView {
        WeatherSummeryView()
            .frame(maxWidth: .infinity)
    }
    .padding(.top, 50)
    .background(.blue)
}
