//
//  MainContentView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct MainContentView: View {
    @ObservedObject var viewModel: SidebarTabViewModel
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        ZStack {
            // Show the appropriate tab view based on selection
            switch viewModel.selectedTab {
            case .copilot:
                CopilotTabView()
            case .audioGen:
                AudioGenTabView()
            case .midiGen:
                MIDIGenTabView()
            case .effectsGen:
                EffectsGenTabView()
            case .audioEdit:
                AudioEditTabView()
            case .settings:
                SettingsView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(themeViewModel.backgroundColor)
    }
}

#Preview {
    MainContentView(viewModel: SidebarTabViewModel())
        .environmentObject(ThemeViewModel())
}
