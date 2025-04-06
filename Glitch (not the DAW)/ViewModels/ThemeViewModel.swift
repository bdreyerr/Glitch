//
//  ThemeViewModel.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

// Theme model to define a collection of colors
struct Theme {
    let id: String
    let name: String
    let backgroundColor: Color
    let secondaryBackgroundColor: Color
    let accentColor: Color
    let textColor: Color
    let secondaryTextColor: Color
    let borderColor: Color
    let controlBackgroundColor: Color
}

class ThemeViewModel: ObservableObject {
    // Available themes
    private let darkGrayTheme = Theme(
        id: "darkGray",
        name: "Dark Gray",
        backgroundColor: Color(red: 0.12, green: 0.12, blue: 0.14),
        secondaryBackgroundColor: Color(red: 0.18, green: 0.18, blue: 0.20),
        accentColor: Color(red: 0.36, green: 0.67, blue: 0.92),
        textColor: Color.white,
        secondaryTextColor: Color(white: 0.7),
        borderColor: Color(red: 0.25, green: 0.25, blue: 0.27),
        controlBackgroundColor: Color(red: 0.22, green: 0.22, blue: 0.24)
    )
    
    private let lightTheme = Theme(
        id: "light",
        name: "Light",
        backgroundColor: Color(red: 0.95, green: 0.95, blue: 0.97),
        secondaryBackgroundColor: Color(red: 0.90, green: 0.90, blue: 0.92),
        accentColor: Color(red: 0.0, green: 0.48, blue: 0.86),
        textColor: Color(red: 0.1, green: 0.1, blue: 0.1),
        secondaryTextColor: Color(red: 0.4, green: 0.4, blue: 0.4),
        borderColor: Color(red: 0.8, green: 0.8, blue: 0.82),
        controlBackgroundColor: Color(red: 0.85, green: 0.85, blue: 0.87)
    )
    
    // All available themes
    var themes: [Theme] {
        [darkGrayTheme, lightTheme]
    }
    
    // Current theme
    @Published var currentTheme: Theme
    
    init() {
        // Set default theme
        self.currentTheme = lightTheme
    }
    
    // Function to switch themes
    func setTheme(id: String) {
        if id == lightTheme.id {
            currentTheme = lightTheme
        } else {
            currentTheme = darkGrayTheme
        }
    }
    
    // Theme accessors for easy access throughout the app
    var backgroundColor: Color { currentTheme.backgroundColor }
    var secondaryBackgroundColor: Color { currentTheme.secondaryBackgroundColor }
    var accentColor: Color { currentTheme.accentColor }
    var textColor: Color { currentTheme.textColor }
    var secondaryTextColor: Color { currentTheme.secondaryTextColor }
    var borderColor: Color { currentTheme.borderColor }
    var controlBackgroundColor: Color { currentTheme.controlBackgroundColor }
}
