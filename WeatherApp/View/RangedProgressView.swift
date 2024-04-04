//
//  RangedProgressView.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 12/03/2024.
//

import SwiftUI

struct RangedProgressView: ProgressViewStyle {
    
    let range: ClosedRange<Double>
    let foregroundColor: AnyShapeStyle
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        return GeometryReader { proxy in
            ZStack(alignment: .leading){
                Capsule()
                    .fill(backgroundColor)
                Capsule()
                    .fill(foregroundColor)
                    .frame(width: proxy.size.width * fillWidthScale)
                    .offset(x: proxy.size.width * range.lowerBound)
                Circle()
                    .foregroundColor(backgroundColor)
                    .frame(width: proxy.size.height + 4.0, height: proxy.size.height + 4.0)
                    .position(x: proxy.size.width * (configuration.fractionCompleted ?? 0.0), y: proxy.size.height/2.0)
                Circle()
                    .foregroundColor(.white)
                    .position(x: proxy.size.width * (configuration.fractionCompleted ?? 0.0), y: proxy.size.height/2.0)

                
            }
            .clipped()
        }
    }
    
    var fillWidthScale: Double {
        let normalizedRange = range.upperBound - range.lowerBound
        return Double(normalizedRange)
    }
    
    
    
}



struct RangedProgressView_Preview: PreviewProvider {
    
    static var previews: some View {
        ScrollView{
            VStack{
                ForEach(0...10, id:\.self){ value in
                    let range = 0.0...(Double(value)/10.0)
                    ProgressView(value: 0.5)
                        .frame(height: 4)
                        .progressViewStyle(RangedProgressView(range: range,
                                                              foregroundColor: AnyShapeStyle(.yellow),
                                                              backgroundColor: .purple
                                                             ))
                        .padding()
                    
                }
            }
        }
    }
}
