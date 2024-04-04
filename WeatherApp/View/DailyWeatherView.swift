//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 03/03/2024.
//

import SwiftUI

struct DailyWeatherView: View {
    
    var weatherForeCast = [Hour]()
    var df = DateFormatter()
    
    init(foreCast: [Hour]? = nil){
        if let hoursforecast = foreCast{
            self.weatherForeCast = WeatherForCastsManeger.sortWeatherForcastTime(hoursforecast)
        }
    }
    
    var body: some View {
        
        VStack{
            
            Text("Conditions may continue all day.")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .font(Font.system(size: 14))
                .fontWeight(.medium)
                .padding(5)
                .shadow(radius: 6)
            
            Divider()
                .padding(.bottom, 10)
            
            ScrollView(.horizontal){
                
                HStack{
                    
                    ForEach(weatherForeCast){ forcast in
                        
                        VStack(){
                            
                            Text(forcast == weatherForeCast.first ? "Now" : WeatherForCastsManeger.formattedHour(from: forcast.time ?? ""))
                                .font(Font.system(size: 16))
                                .fontWeight(.semibold)
                            
                            let currentIcon = WeatherIcons.icons.filter({$0.code == forcast.condition?.code})
                            
                            Image(forcast.is_day == 0 ? "\(currentIcon.first?.icon ?? 0)N" : "\(currentIcon.first?.icon ?? 0)")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 40, maxHeight: 40)
                                .padding(.vertical, 2)
                            
                            Text("\(forcast.temp_c ?? 0.0, specifier: "%.0f")°")
                                .font(Font.system(size: 20))
                                .fontWeight(.medium)
                            
                        }.foregroundColor(.white)
                            .padding(.horizontal, 8)
                        
                    }
                }
            }
        }
        .padding(14)
        .scrollIndicators(.hidden)
        .background{
            VisualEffectView(effect: UIBlurEffect(style: .regular))
        }
        .cornerRadius(16.0)
        
        
    }
    
    
}


#Preview {
    DailyWeatherView()
        .padding(14)
        .frame(maxHeight: .infinity)
        .background(.blue)
    
}
