//
//  SubSidebar.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/6/25.
//

import SwiftUI

// Define the possible tabs for the sub sidebar
enum SidebarTab {
    case tracks
    case sequencer
    case marketplace
    case social
    case settings
}

struct SubSidebar: View {
    // State variable to keep track of the currently selected tab
    // In a real app, this might be a @Binding or come from an EnvironmentObject
    @ObservedObject var viewModel: SidebarTabViewModel
    @EnvironmentObject private var themeViewModel: ThemeViewModel

    var body: some View {
        VStack {
            // Switch based on the selected tab to display different content
            switch viewModel.selectedTab {
            case .copilot:
                Text("Heyza")
            case .audioGen:
                Text("Heyza")
            case .midiGen:
                Text("Heyza")
            case .effectsGen:
                Text("Heyza")
            case .audioEdit:
                Text("Heyza")
            case .settings:
                Text("Heyza")
            }
            Spacer() // Pushes content to the top
        }
        .padding() // Add some padding around the content
        .frame(maxWidth: 200, maxHeight: .infinity) // Make the VStack take available space
        .background(themeViewModel.secondaryBackgroundColor)
        .border(themeViewModel.borderColor.opacity(0.7), width: 1) // Add a border with the text color at reduced opacity
    }
}
