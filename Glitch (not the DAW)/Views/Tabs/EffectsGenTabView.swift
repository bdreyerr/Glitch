//
//  EffectsGenTabView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct EffectsGenTabView: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        VStack {
            Text("Effects Generation")
                .font(.largeTitle)
                .foregroundColor(themeViewModel.textColor)
                .padding()
            
            Text("Create audio effects with AI")
                .foregroundColor(themeViewModel.secondaryTextColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeViewModel.backgroundColor)
    }
}

#Preview {
    EffectsGenTabView()
        .environmentObject(ThemeViewModel())
} 