//
//  TextEditor.swift
//  Glitch (not the DAW)
//
//  Created by Ben Dreyer on 4/5/25.
//

import SwiftUI

struct TextEditorView: View {
    @State private var text: String = ""
    @EnvironmentObject private var themeViewModel: ThemeViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Button {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
                panel.canChooseFiles = true
                if panel.runModal() == .OK {
                    // For now, just print the selected URL.
                    // Later, you can handle the selected file here.
                    print("File selected: \(panel.url?.path ?? "No file selected")")
                }
            } label: {
                Image(systemName: "paperclip.circle.fill")
                    .font(.title2)
                    .foregroundColor(themeViewModel.accentColor)
            }
            .buttonStyle(.plain)

            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text("Ask anything")
                        .foregroundColor(themeViewModel.textColor.opacity(0.6))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .offset(y: 1)
                }
                
                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .foregroundColor(themeViewModel.textColor)
                    .lineSpacing(2)
                    .frame(minHeight: 36)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 5)
                    .fixedSize(horizontal: false, vertical: true)
                    .scrollIndicators(.hidden)
            }

            Button {
                print("Send button tapped. Text: \(text)")
            } label: {
                Image(systemName: text.isEmpty ? "arrow.up.circle" : "arrow.up.circle.fill")
                    .font(.title2)
                    .foregroundColor(text.isEmpty ? themeViewModel.textColor.opacity(0.6) : themeViewModel.accentColor)
            }
            .buttonStyle(.plain)
            .disabled(text.isEmpty)
            .padding(.bottom, 5)

        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(themeViewModel.secondaryBackgroundColor.opacity(0.6))
        .cornerRadius(20)
    }
}

#Preview {
    TextEditorView()
        .environmentObject(ThemeViewModel())
        .padding()
        .background(Color.gray.opacity(0.2))
}
