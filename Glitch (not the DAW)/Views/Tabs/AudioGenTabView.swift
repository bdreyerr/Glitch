//
//  AudioGenTabView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct AudioGenTabView: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        VStack {
            Text("Audio Generation")
                .font(.largeTitle)
                .foregroundColor(themeViewModel.textColor)
                .padding()
            
            Text("Create audio with AI")
                .foregroundColor(themeViewModel.secondaryTextColor)
            
            
            HStack(spacing: 20) {
                AudioCard(audioFilename: "1", volume: 0.25)
                AudioCard(audioFilename: "2", volume: 0.25)
                AudioCard(audioFilename: "3", volume: 0.25)
            }
            .padding(.vertical, 40)
            
            
            
            TextEditorView()
                .padding(.horizontal, 100)
                .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeViewModel.backgroundColor)
    }
}

#Preview {
    AudioGenTabView()
        .environmentObject(ThemeViewModel())
} 
