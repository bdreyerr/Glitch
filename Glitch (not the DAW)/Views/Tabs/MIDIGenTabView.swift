//
//  MIDIGenTabView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct MIDIGenTabView: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        VStack {
            Text("MIDI Generation")
                .font(.largeTitle)
                .foregroundColor(themeViewModel.textColor)
                .padding()
            
            Text("Create MIDI with AI")
                .foregroundColor(themeViewModel.secondaryTextColor)
            
            
            
            TextEditorView()
                .padding(.horizontal, 100)
                .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeViewModel.backgroundColor)
    }
}

#Preview {
    MIDIGenTabView()
        .environmentObject(ThemeViewModel())
} 
