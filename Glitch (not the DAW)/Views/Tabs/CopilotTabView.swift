//
//  CopilotTabView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct CopilotTabView: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        VStack {
            Text("What are you making?")
                .font(.largeTitle)
                .foregroundColor(themeViewModel.textColor)
                .padding()
            
            Spacer()
            
            // Container view for chat
                
            
            TextEditorView()
                .padding(.horizontal, 100)
                .padding(.bottom, 40)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeViewModel.backgroundColor)
    }
}

#Preview {
    CopilotTabView()
        .environmentObject(ThemeViewModel())
} 
