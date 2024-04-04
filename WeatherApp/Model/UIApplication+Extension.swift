//
//  UIApplication+Extension.swift
//  WeatherApp
//
//  Created by kholoud alhamzawy on 10/03/2024.
//

import UIKit
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


enum AppTheme {
    case night, day
    
    var linearGradient: LinearGradient {
        switch self {
        case .night:
            return LinearGradient(colors: [Color(red: 0.006660151295, green: 0.01419456583, blue: 0.09943637997),
                                           Color(red: 0.187584132, green: 0.2576737404, blue: 0.4073661566)],
                                  startPoint: .top, endPoint: .bottom)
        case .day:
            return LinearGradient(colors: [Color(red: 0.23, green: 0.33, blue: 0.52),
                                           Color(red: 0.75, green: 0.59, blue: 0.62)],
                                  startPoint: .top, endPoint: .bottom)
        }
    }
}

extension Color {
    static var currentTheme: AppTheme = .night
    static var progressBarGradiantColors: [Color] {
        return [Color(red: 0.39, green: 0.8, blue: 0.74), Color(red: 0.96, green: 0.8, blue: 0.0)]
    }
    static var progressBarBackGroundColor = Color(red: 0.25, green: 0.35, blue: 0.72).opacity(0.2)
}

extension LinearGradient {
    
    static var progressBarGradient: LinearGradient {
        return LinearGradient(colors:Color.progressBarGradiantColors, startPoint: .leading, endPoint: .trailing)
    }
}
