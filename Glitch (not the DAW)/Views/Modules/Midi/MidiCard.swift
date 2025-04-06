//
//  MidiCard.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/6/25.
//

import SwiftUI

struct MidiCard: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    @State private var isHovering = false
    var body: some View {
        VStack {
            HStack {
                Text("A Minor Chord Progression")
                    .font(.caption)
//                Spacer()
            }
            VStack {
                // Pass current time, duration, and seek handler to Waveform
                
                //            Text("Swamp Izzo snare roll")
                
                HStack {
                    // Audio Info - Updated to show dynamic time
//                    Text("\(formatTime(currentTime)) / \(formatTime(totalDuration))")
//                        .font(.caption)
//                        .monospacedDigit() // Ensures consistent spacing for numbers
//                        .opacity(0.6)
//                    
//                    Text("41.6kHz")
//                        .font(.caption)
//                        .opacity(0.6)
                }
            }
            .frame(width: 300, height: 150)
            .frame(maxWidth: 300)
            .cornerRadius(12)
            // Apply overlay with rounded rectangle instead of border for curved corners
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isHovering ? Color.accentColor : themeViewModel.borderColor, lineWidth: isHovering ? 2 : 1)
            )
            // Add hover detection
            .onHover { hovering in
                isHovering = hovering
            }
        }
    }
}
