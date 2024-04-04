//
//  CitiesWeather.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 03/03/2024.
//

import SwiftUI

struct CitiesWeather: View {
    
    @StateObject private var viewModel = WeatherAppViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor.secondaryLabel
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        
        ZStack {
            NavigationView{
                
                ScrollView(.vertical){
                    HStack {
                        
                        Button { 
                            
                            viewModel.getWeatherForecast()
                            
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                        .padding(.leading, 7)
                        
                        TextField("", text: $viewModel.location,
                                  prompt: Text("Search for a city")
                            .foregroundColor(.white.opacity(0.4))
                        )
                        .foregroundColor(.white)
                        .frame(height: 35)
                        .accentColor(.white)
                        .textFieldStyle(.plain)
                        
                        Button(action: {
                            viewModel.location = ""
                        }) {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 7)
                        
                    }
                    .background(.gray.opacity(0.4))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    
                    Spacer()
                    
                    ForEach(viewModel.forecasts) { forecast in
                        
                        NavigationLink(destination: tabWeatherView(weatherForcast: viewModel.forecasts)) {
                            
                            HStack{
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(forecast.location?.name ?? "")
                                        .font(Font.system(size: 26))
                                        .fontWeight(.semibold)
                                        .padding(.bottom, 1)
                                        .shadow(radius: 2.0)
                                    
                                    Text(WeatherForCastsManeger.formattedTime(from: forecast.location?.localtime ?? ""))
                                        .font(Font.system(size: 16))
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                    
                                    Text(forecast.current?.condition?.text ?? "")
                                        .font(Font.system(size: 16))
                                        .fontWeight(.medium)
                                    
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing){
                                    Text("\(forecast.current?.temp_c ?? 0.0, specifier: "%.0f")°")
                                        .font(Font.system(size: 50))
                                        .fontWeight(.light)
                                        .shadow(radius: 2.0)
                                    
                                    Spacer()
                                    
                                    Text("H:\(forecast.forecast?.forecastday?[0].day?.maxtemp_c ?? 0.0, specifier: "%.0f")° L:\(forecast.forecast?.forecastday?[0].day?.mintemp_c ?? 0.0, specifier: "%.0f")°")
                                        .font(Font.system(size: 16))
                                        .fontWeight(.medium)
                                }
                            }
                            .frame(minHeight: 105)
                            .padding(16)
                            .background{
                                VisualEffectView(effect: UIBlurEffect(style: .regular))
                            }
                            .cornerRadius(16.0)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                        }
                    }
                    
                }
                .background(Color.currentTheme.linearGradient)
                .navigationTitle(Text("Weather"))
                .foregroundColor(.white)
                .alert(item: $viewModel.appError) { appAlert in
                    Alert(title: Text("Error"),
                          message: Text("""
                        \(appAlert.errorString)
                        Please try again later!
                        """)
                    )
                }
            }
            
            if viewModel.isLoading {
                ZStack {
                    ProgressView("Fetching Weather")
                        .padding()
                        .background(
                            VisualEffectView(effect: UIBlurEffect(style: .regular)))
                        .cornerRadius(10)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ )
                }
            }
        }
    }
 
}

#Preview {
    CitiesWeather()
}
