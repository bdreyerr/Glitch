//
//  ControlBarView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct ControlBarView: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Text("New Project")
                .foregroundColor(themeViewModel.textColor)
            Spacer()
        }
        .padding(10)
        .background(themeViewModel.controlBackgroundColor)
        .border(themeViewModel.borderColor, width: 1)
    }
}

#Preview {
    ControlBarView()
        .environmentObject(ThemeViewModel())
}
