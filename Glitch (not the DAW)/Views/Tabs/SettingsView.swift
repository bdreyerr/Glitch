//
//  SettingsView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.largeTitle)
                .foregroundColor(themeViewModel.textColor)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Theme")
                    .font(.headline)
                    .foregroundColor(themeViewModel.textColor)
                    .padding(.horizontal)
                
                ForEach(themeViewModel.themes, id: \.id) { theme in
                    ThemeSelectionRow(
                        themeName: theme.name, 
                        isSelected: themeViewModel.currentTheme.id == theme.id,
                        accentColor: theme.accentColor,
                        backgroundColor: theme.backgroundColor
                    ) {
                        themeViewModel.setTheme(id: theme.id)
                    }
                }
            }
            .padding()
            .background(themeViewModel.secondaryBackgroundColor)
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(themeViewModel.backgroundColor)
    }
}

struct ThemeSelectionRow: View {
    let themeName: String
    let isSelected: Bool
    let accentColor: Color
    let backgroundColor: Color
    let action: () -> Void
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        Button(action: action) {
            HStack {
                HStack(spacing: 10) {
                    // Theme color preview
                    HStack(spacing: 0) {
                        backgroundColor
                            .frame(width: 20, height: 20)
                        accentColor
                            .frame(width: 10, height: 20)
                    }
                    .cornerRadius(4)
                    
                    Text(themeName)
                        .foregroundColor(themeViewModel.textColor)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(themeViewModel.accentColor)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(isSelected ? themeViewModel.accentColor.opacity(0.1) : Color.clear)
            .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SettingsView()
        .environmentObject(ThemeViewModel())
}
