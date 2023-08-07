//
//  Themes.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI

struct Themes {
    static let background = LinearGradient(gradient: Gradient(colors: [Color(red: 0.9, green: 0.95, blue: 1.0), Color(red: 0.7, green: 0.85, blue: 0.95)]), startPoint: .top, endPoint: .bottom)
    
    static let darkBackground =  LinearGradient(
        gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.9), Color(red: 1.0, green: 0.8, blue: 0.8)]),
        startPoint: .top,
        endPoint: .bottom)
    
    static let other = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.9, green: 1.0, blue: 0.9), Color(red: 0.8, green: 0.95, blue: 0.8)]),
        startPoint: .top,
        endPoint: .bottom
    )
    
}

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
