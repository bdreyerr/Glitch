//
//  Waveform.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/6/25.
//

import SwiftUI

struct Waveform: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    // Store the randomly generated points for the waveform
    @State private var waveformPoints: [CGFloat] = []
    // Define the number of points in the waveform - increased for more detail
    private let pointCount = 250
    
    // Add properties to track playback progress
    var currentTime: TimeInterval
    var totalDuration: TimeInterval
    // Add callback for seeking
    var onSeek: ((TimeInterval) -> Void)?
    // Add callback for when scrubbing ends
    var onScrubEnd: (() -> Void)?
    
    var progressRatio: CGFloat {
        CGFloat(currentTime) / CGFloat(totalDuration)
    }

    // Define colors similar to the reference image
//    private let waveformFillColor = Color(red: 0.2, green: 0.15, blue: 0.1) // Dark brown/black - REMOVED
//    private let waveformBackgroundColor = Color(red: 0.6, green: 0.5, blue: 0.4) // Light brown/beige - REMOVED

    var body: some View {
        GeometryReader { geometry in
            // Create the waveform path once
            let waveformPath = createWaveformPath(geometry: geometry, points: waveformPoints)
            
            // Calculate progress ratio
            let progressRatio = totalDuration > 0 ? CGFloat(currentTime / totalDuration) : 0

            // Draw the base waveform (unplayed part)
            waveformPath
                .fill(themeViewModel.textColor.opacity(0.8))
                // Overlay the progress waveform (played part) with clipping
                .overlay(
                    // Draw the same path again for the overlay
                    waveformPath
                        .fill(Color.accentColor) // Use accent color for progress
                        // Clip the overlayed path to show only the progress
                        .clipShape(Rectangle().path(in: CGRect(x: 0, y: 0, width: geometry.size.width * progressRatio, height: geometry.size.height)))
                )
            // Ensure the whole area is tappable
            .contentShape(Rectangle()) 
            // Use DragGesture with minimumDistance: 0 to handle taps as well as drags
            .gesture(
                DragGesture(minimumDistance: 0) // Detect taps with 0 distance
                    .onChanged { value in
                        // Update position continuously during drag for scrubbing
                        guard totalDuration > 0 else { return }
                        let locationX = value.location.x
                        let width = geometry.size.width
                        let clampedX = max(0, min(locationX, width))
                        let seekRatio = clampedX / width
                        let seekTime = TimeInterval(seekRatio) * totalDuration
                        
                        print("[Waveform] Scrubbing: X=\(locationX), ratio=\(seekRatio), time=\(seekTime)")
                        
                        // Call the callback for continuous updates
                        onSeek?(seekTime)
                    }
                    .onEnded { value in
                        guard totalDuration > 0 else { return } // Prevent seeking if duration is 0
                        let locationX = value.location.x
                        let width = geometry.size.width
                        // Clamp locationX to bounds 0...width
                        let clampedX = max(0, min(locationX, width))
                        let seekRatio = clampedX / width
                        let seekTime = TimeInterval(seekRatio) * totalDuration
                        
                        // --- DEBUG LOGS --- 
                        print("[Waveform] Tapped at X: \(locationX), Clamped X: \(clampedX)")
                        print("[Waveform] Geometry Width: \(width)")
                        print("[Waveform] Calculated Seek Ratio: \(seekRatio)")
                        print("[Waveform] Calculated Seek Time: \(seekTime)")
                        // --- END DEBUG LOGS ---
                        
                        // Call the callback
                        print("[Waveform] Calling onSeek callback for final position...")
                        onSeek?(seekTime)
                        
                        // Notify that scrubbing has ended
                        print("[Waveform] Scrubbing ended, calling onScrubEnd...")
                        onScrubEnd?()
                        
                        print("[Waveform] callbacks finished.")
                    }
            )
        }
        // Generate the random waveform data when the view appears
        .onAppear(perform: generateWaveformPoints)
        // Set a default frame for the preview
        .frame(height: 100)
        // Clip the waveform to its bounds
        .clipped()
    }
    
    // Helper function to create the full waveform path
    private func createWaveformPath(geometry: GeometryProxy, points: [CGFloat]) -> Path {
        Path { path in
            let width = geometry.size.width
            let height = geometry.size.height
            let middleY = height / 2
            let spacing = points.count > 1 ? width / CGFloat(points.count - 1) : width
            
            guard !points.isEmpty else {
                path.move(to: CGPoint(x: 0, y: middleY))
                path.addLine(to: CGPoint(x: width, y: middleY))
                return
            }
            
            path.move(to: CGPoint(x: 0, y: middleY))
            
            // Draw top half
            for index in 0..<points.count {
                let x = CGFloat(index) * spacing
                let amplitude = points[index] * middleY
                let y = middleY + max(-middleY, min(middleY, amplitude))
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: width, y: middleY))
            
            // Draw bottom half (mirrored)
            for index in (0..<points.count).reversed() {
                let x = CGFloat(index) * spacing
                let amplitude = points[index] * middleY
                let y = middleY - max(-middleY, min(middleY, amplitude))
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.closeSubpath()
        }
    }

    // Function to generate random waveform data
    private func generateWaveformPoints() {
        // Ensure we only generate points once
        guard waveformPoints.isEmpty else { return }

        var rawPoints = [CGFloat]()
        for _ in 0..<pointCount {
            // Generate random values between -1.0 and 1.0
            rawPoints.append(CGFloat.random(in: -1.0...1.0))
        }

        // Apply a simple moving average for smoothing
        var smoothedPoints = [CGFloat]()
        if pointCount > 0 {
            // Handle the first point (average of first two)
            if pointCount >= 2 {
                 smoothedPoints.append((rawPoints[0] + rawPoints[1]) / 2.0)
            } else {
                 smoothedPoints.append(rawPoints[0]) // Only one point
            }
           
            // Handle middle points (average of three points: previous, current, next)
            for i in 1..<(pointCount - 1) {
                let smoothedValue = (rawPoints[i-1] + rawPoints[i] + rawPoints[i+1]) / 3.0
                smoothedPoints.append(smoothedValue)
            }

            // Handle the last point (average of last two)
            if pointCount >= 2 {
                 smoothedPoints.append((rawPoints[pointCount-2] + rawPoints[pointCount-1]) / 2.0)
            }
        }

        self.waveformPoints = smoothedPoints
    }
}

// Add Preview if it doesn't exist or update existing one
#Preview {
    Waveform(
        currentTime: 15.0, // Example current time for preview
        totalDuration: 60.0, // Example total duration for preview
        onSeek: { time in print("Preview seeked to: \(time)") }, // Example seek action
        onScrubEnd: { print("Preview scrub ended") } // Example scrub end action
    )
        .environmentObject(ThemeViewModel()) // Inject ThemeViewModel for Preview
        .padding()
        .background(ThemeViewModel().backgroundColor) // Set preview background
}
