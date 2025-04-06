//
//  ContentView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var themeViewModel = ThemeViewModel()
    
    var body: some View {
        GlitchContainerView()
            .environmentObject(themeViewModel)
            .preferredColorScheme(.dark) // Force dark mode for better compatibility with our theme
    }
}

#Preview {
    ContentView()
}
