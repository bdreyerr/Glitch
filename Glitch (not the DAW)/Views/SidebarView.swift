//
//  SidebarView.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct SidebarView: View {
    @ObservedObject var viewModel: SidebarTabViewModel
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(TabSelection.allCases) { tab in
                TabButton(
                    iconName: tab.iconName,
                    image: tab.image,
                    isSelected: viewModel.selectedTab == tab,
                    action: {
                        viewModel.selectTab(tab)
                    }
                )
            }
            
            Spacer()
        }
        .padding(.top, 30)
        .frame(width: 60)
        .background(themeViewModel.secondaryBackgroundColor)
    }
}

struct TabButton: View {
    let iconName: String
    let image: String
    let isSelected: Bool
    let action: () -> Void
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        Button(action: action) {
            if iconName == "use-image" {
                Image(image)
                    .resizable()
                    .foregroundColor(isSelected ? themeViewModel.accentColor : themeViewModel.textColor)
                    .frame(width: 44, height: 44)
                    .background(
                        isSelected ?
                            themeViewModel.accentColor.opacity(0.2) :
                            Color.clear
                    )
//                    .cornerRadius(10)
                    .clipShape(Circle())
            } else {
                Image(systemName: iconName)
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? themeViewModel.accentColor : themeViewModel.textColor)
                    .frame(width: 44, height: 44)
                    .background(
                        isSelected ?
                        themeViewModel.accentColor.opacity(0.2) :
                            Color.clear
                    )
                    .cornerRadius(10)
                    .contentShape(Rectangle())
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SidebarView(viewModel: SidebarTabViewModel())
        .environmentObject(ThemeViewModel())
}
