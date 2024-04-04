//
//  WeeklyWeatherView.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 03/03/2024.
//

import SwiftUI

struct WeeklyWeatherView: View {
    
    var weatherForeCast = [Forecastday]()
    
    init(foreCast: [Forecastday]? = nil){
        if let hoursforecast = foreCast{
            self.weatherForeCast = hoursforecast
            
        }
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Image(systemName: "calendar")
                Text("\(weatherForeCast.count)-DAY FORECAST")
                    .font(Font.system(size: 14))
                    .fontWeight(.medium)
            }.foregroundColor(.white.opacity(0.6))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(0..<weatherForeCast.count, id: \.self){ index in
                
                Divider()
                    .background(.white)
                    .frame(maxHeight: 0.16)
                
                HStack{
                    
                    Text(index == 0 ? "Today" : WeatherForCastsManeger.extractDay(from: weatherForeCast[index].date ?? "") ?? "")
                        .font(Font.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: 60
                               ,alignment: .leading)
                        .padding(.leading,7)
                    
                    Spacer()
                    
                    let currentIcon = WeatherIcons.icons.filter({$0.code ==  weatherForeCast[index].day?.condition?.code})
                    Image("\(currentIcon.first?.icon ?? 0)")
                    
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 40)
                    
                    Spacer()
                    
                    Text("\( weatherForeCast[index].day?.mintemp_c ?? 0, specifier: "%.0f")°")
                        .font(Font.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.6))
                    
                    Spacer()
                        .frame(maxWidth: 8)
                    
//                    ProgressView(value: abs(weatherForeCast[index].day?.avgtemp_c ?? 0), total: 60)
                    ProgressView(value: 40, total: 60)
                        .progressViewStyle(RangedProgressView(range:0.2...0.8,
                                                              foregroundColor: AnyShapeStyle(LinearGradient.progressBarGradient),
                                                              backgroundColor: Color.progressBarBackGroundColor
                                                             )
                        )
                        .frame(maxWidth: 85, maxHeight: 4.0)
                    
                    Spacer()
                        .frame(maxWidth: 8)
                    
                    Text("\( weatherForeCast[index].day?.maxtemp_c ?? 0, specifier: "%.0f")°")
                        .font(Font.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 2)
            }
            
        }
        .padding(14)
        .background{
            VisualEffectView(effect: UIBlurEffect(style: .regular))
        }
        .cornerRadius(16.0)
        
        
    }
    
    
}

#Preview {
    ScrollView{
        WeeklyWeatherView()
            .padding(14)
        
    }
    .frame(maxHeight: .infinity)
    .background(.blue)
    
}
