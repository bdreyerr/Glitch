//
//  GlitchContainerView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct GlitchContainerView: View {
    @StateObject private var sidebarViewModel = SidebarTabViewModel()
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        // Main Container
        VStack {
            // Control Bar
//            ControlBarView()
            
            HStack(spacing: 0) {
                // Sidebar
                SidebarView(viewModel: sidebarViewModel)
                
                SubSidebar(viewModel: sidebarViewModel)
                
                // Main Content
                MainContentView(viewModel: sidebarViewModel)
            }
        }
        .background(themeViewModel.backgroundColor)
        .foregroundColor(themeViewModel.textColor)
    }
}

#Preview {
    GlitchContainerView()
        .environmentObject(ThemeViewModel())
}
