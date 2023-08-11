//
//  Themes.swift
//  View
//
//  Created by Abhiraj on 06/08/23.
//

import SwiftUI

struct Themes {
    static let primary = LinearGradient(gradient: Gradient(colors: [Color(red: 0.9, green: 0.95, blue: 1.0).opacity(0.5), Color(red: 0.7, green: 0.85, blue: 0.95).opacity(0.5)]), startPoint: .top, endPoint: .bottom)
    
    static let secondary =  LinearGradient(
        gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.9).opacity(0.4), Color(red: 1.0, green: 0.8, blue: 0.4).opacity(0.8)]),
        startPoint: .top,
        endPoint: .bottom)
    
    static let tertiary = LinearGradient(
        gradient: Gradient(colors: [Color(red: 0.9, green: 1.0, blue: 0.9).opacity(0.7), Color(red: 0.8, green: 0.95, blue: 0.8).opacity(0.7)]),
        startPoint: .top,
        endPoint: .bottom
    )
    
}

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}


