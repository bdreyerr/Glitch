//
//  AudioEditTabView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct AudioEditTabView: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        VStack {
            Text("Audio Editor")
                .font(.largeTitle)
                .foregroundColor(themeViewModel.textColor)
                .padding()
            
            Text("Edit and process audio")
                .foregroundColor(themeViewModel.secondaryTextColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeViewModel.backgroundColor)
    }
}

#Preview {
    AudioEditTabView()
        .environmentObject(ThemeViewModel())
} 