//
//  SidebarTabViewModel.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import Foundation
import SwiftUI

enum TabSelection: String, CaseIterable, Identifiable {
    case copilot, audioGen, midiGen, effectsGen, audioEdit, settings
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .copilot:
            return "use-image"
        case .audioGen:
            return "waveform.path"
        case .midiGen:
            return "pianokeys"
        case .effectsGen:
            return "slider.horizontal.3"
        case .audioEdit:
            return "pencil"
        case .settings:
            return "gearshape"
        }
    }
    
    var title: String {
        switch self {
        case .copilot:
            return "Copilot"
        case .audioGen:
            return "Audio Gen"
        case .midiGen:
            return "MIDI Gen"
        case .effectsGen:
            return "Effects Gen"
        case .audioEdit:
            return "Audio Edit"
        case .settings:
            return "Settings"
        }
    }
    
    var image: String {
        switch self {
        case .copilot:
            return "logo"
        case .audioGen:
            return "logo"
        case .midiGen:
            return "logo"
        case .effectsGen:
            return "logo"
        case .audioEdit:
            return "logo"
        case .settings:
            return "logo"
        }
    }
}

class SidebarTabViewModel: ObservableObject {
    @Published var selectedTab: TabSelection = .copilot
    
    func selectTab(_ tab: TabSelection) {
        selectedTab = tab
    }
}
