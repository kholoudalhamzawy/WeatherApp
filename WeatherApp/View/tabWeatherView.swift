//
//  tabWeatherView.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 05/03/2024.
//

import SwiftUI

struct tabWeatherView: View {
    
    
    var weatherForcast = [WeatherForeCastResponseModel]()
    @StateObject private var viewModel = WeatherAppViewModel()
    @State var offset: CGFloat = 0
    @Environment(\.presentationMode) private var presentationMode
    
    
    var body: some View {
        
        TabView{
            
            ForEach( 0..<weatherForcast.count , id: \.self) { modelIndex in
                
                CityWeatherView(weatherForcast: weatherForcast[modelIndex])
                    .overlay(
                        GeometryReader{
                            proxy -> Color in
                            
                            let minX = proxy.frame(in: .global).minX
                            
                            DispatchQueue.main.async {
                                withAnimation(.default){
                                    let width = UIScreen.main.bounds.width
                                    self.offset = -minX + CGFloat((width * CGFloat(modelIndex)))
                                }
                            }
                            
                            return Color.clear
                        }
                            .frame(width: 0, height: 0)
                        ,alignment: .leading
                    )
            }
            
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(.page(backgroundDisplayMode: .never))
        .overlay(
            VStack(){
                
                Spacer()
                HStack(spacing: 20){
                    Button(action: {
                        
                        // open maps action
                    }) {
                        Image(systemName: "map")
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 10){
                        
                        ForEach( 0..<weatherForcast.count , id: \.self) { index in
                            
                            if index == 0 {
                                
                                Image(systemName: "location.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(getIndex() == 0 ? Color.white : Color.white.opacity(0.6))
                                    .frame(width: 12, height: 12)
                            } else {
                                
                                Capsule()
                                    .fill(getIndex() == index ? Color.white : Color.white.opacity(0.6))
                                    .frame(width: 7, height: 7)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 20 )
                .padding(.bottom, 45)
                .frame(maxWidth: .infinity)
                .background{
                    VisualEffectView(effect: UIBlurEffect(style: .regular))
                }
            }
        )
        .background(Color.currentTheme.linearGradient)
        .ignoresSafeArea(.all)
        
    }
    
    func getIndex()->Int{
        let width = UIScreen.main.bounds.width
        let index = Int(round(Double(offset / width)))
        return index
    }
    
    
}

#Preview {
    tabWeatherView()
}
