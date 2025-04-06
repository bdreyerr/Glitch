//
//  AudioCard.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/6/25.
//

import SwiftUI
import AVFoundation // Import AVFoundation for audio playback

struct AudioCard: View {
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    // Add a parameter for the audio filename (without extension)
    let audioFilename: String
    // Add a parameter for the playback volume (0.0 to 1.0)
    let volume: Float
    
    // State to track hover status
    @State private var isHovering = false
    // State to hold the audio player instance
    @State private var audioPlayer: AVAudioPlayer?
    // State to track playback time
    @State private var currentTime: TimeInterval = 0.0
    @State private var totalDuration: TimeInterval = 0.0
    // Timer for updating progress
    @State private var progressTimer: Timer?
    // State to track if scrubbing
    @State private var isScrubbing: Bool = false
    // State to remember if audio was playing before scrubbing
    @State private var wasPlayingBeforeScrubbing: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text("Swamp Izzo - Snare Roll")
                    .font(.caption)
//                Spacer()
            }
            VStack {
                // Pass current time, duration, and seek handler to Waveform
                Waveform(
                    currentTime: currentTime,
                    totalDuration: totalDuration,
                    onSeek: seekAudio, // Pass the seek function
                    onScrubEnd: finishScrubbing // Pass the scrub end handler
                )
                
                //            Text("Swamp Izzo snare roll")
                
                HStack {
                    // Audio Info - Updated to show dynamic time
                    Text("\(formatTime(currentTime)) / \(formatTime(totalDuration))")
                        .font(.caption)
                        .monospacedDigit() // Ensures consistent spacing for numbers
                        .opacity(0.6)
                    
                    Text("41.6kHz")
                        .font(.caption)
                        .opacity(0.6)
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
                if hovering {
                    // Only start playing if not in the middle of a scrub
                    if !isScrubbing {
                        audioPlayer?.play()
                        // Start timer to update current time
                        startTimer()
                    }
                } else {
                    // If we're leaving while scrubbing, finish the scrub first
                    if isScrubbing {
                        finishScrubbing()
                    }
                    
                    // Stop playback and reset time on hover end
                    audioPlayer?.stop()
                    audioPlayer?.currentTime = 0 // Reset playback to the beginning
                    // Stop timer and reset time display
                    stopTimer()
                    currentTime = 0.0
                }
            }
            // Load the audio file when the view appears
            .onAppear(perform: loadAudio)
            // Invalidate timer when the view disappears
            .onDisappear(perform: stopTimer)
        }
    }
    
    // Function to handle seeking the audio player
    private func seekAudio(to time: TimeInterval) {
        // Ensure time is within valid bounds (0 to duration)
        let clampedTime = max(0, min(time, totalDuration))
        
        // --- DEBUG LOGS --- 
        print("[AudioCard] seekAudio called with time: \(time)")
        print("[AudioCard] Clamped seek time: \(clampedTime), Total duration: \(totalDuration)")
        // --- END DEBUG LOGS ---
        
        // If this is the start of a scrubbing operation (first drag event)
        if !isScrubbing {
            // Remember if we were playing before scrubbing started
            wasPlayingBeforeScrubbing = audioPlayer?.isPlaying ?? false
            // Enter scrubbing mode
            isScrubbing = true
            
            // Temporarily pause during the scrub if it was playing
            if wasPlayingBeforeScrubbing {
                audioPlayer?.pause()
                print("[AudioCard] Paused playback for scrubbing")
            }
        }
        
        // Set the new time position
        audioPlayer?.currentTime = clampedTime
        // Update the currentTime state immediately for UI responsiveness
        self.currentTime = clampedTime
        print("[AudioCard] Set currentTime to \(clampedTime)")
        
        // Note: Scrubbing end is now detected via the onScrubEnd callback from Waveform
    }
    
    // Helper to finish scrubbing consistently
    private func finishScrubbing() {
        guard isScrubbing else { return }
        
        isScrubbing = false
        // If we were playing before the scrub started and still hovering, resume playback
        if wasPlayingBeforeScrubbing && isHovering {
            audioPlayer?.play()
            print("[AudioCard] Resumed playback after scrubbing ended")
        }
    }
    
    // Function to load the audio file
    private func loadAudio() {
        // Assuming the audio files are in the main bundle and are mp3 files
        // Please change "mp3" if your files have a different extension (e.g., "wav", "m4a")
        guard let soundURL = Bundle.main.url(forResource: audioFilename, withExtension: "mp3") else {
            print("Could not find the audio file: \(audioFilename).mp3")
            return
        }
        
        do {
            // Initialize the audio player
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay() // Prepare the player for playback
            // Get total duration
            totalDuration = audioPlayer?.duration ?? 0.0
            // Set the volume
            audioPlayer?.volume = self.volume
        } catch {
            print("Error loading audio file \(audioFilename).mp3: \(error.localizedDescription)")
        }
    }
    
    // Function to start the progress timer
    private func startTimer() {
        // Invalidate any existing timer first
        stopTimer()
        // Schedule a new timer
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            // Ensure player exists and is playing
            guard let player = audioPlayer, player.isPlaying else {
                // If player stopped unexpectedly, stop timer
                stopTimer()
                return
            }
            self.currentTime = player.currentTime
            
            // Optional: Stop timer if playback reaches the end naturally
            // This might not be strictly necessary with hover-to-stop
//            if self.currentTime >= self.totalDuration {
//                stopTimer()
//            }
        }
    }
    
    // Function to stop and invalidate the progress timer
    private func stopTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    // Helper function to format time interval (seconds) into MM:SS string
    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        // Use String(format:) for leading zeros
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
