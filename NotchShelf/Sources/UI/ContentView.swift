import SwiftUI

struct ContentView: View {
    @EnvironmentObject var state: SharedState
    
    var body: some View {
        VStack(spacing: 0) {
            // Anchor to the top (the physical notch)
            
            ZStack(alignment: .top) {
                // Background Liquid Glassmorphism
                RoundedRectangle(cornerRadius: state.isExpanded ? 24 : 16, style: .continuous)
                    .fill(Material.ultraThin)
                    .overlay(
                        RoundedRectangle(cornerRadius: state.isExpanded ? 24 : 16, style: .continuous)
                            .stroke(Color.white.opacity(0.12), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                // Content
                VStack(spacing: 0) {
                    if state.isExpanded {
                        ExpandedView()
                            .transition(.asymmetric(
                                insertion: .opacity.combined(with: .scale(scale: 0.95)),
                                removal: .opacity.combined(with: .scale(scale: 0.95))
                            ))
                    } else {
                        CollapsedView()
                            .transition(.opacity)
                    }
                }
                .clipped()
            }
            .frame(
                width: state.isExpanded ? 360 : 200,
                height: state.isExpanded ? 320 : 36
            )
            .animation(.spring(response: 0.32, dampingFraction: 0.75), value: state.isExpanded)
            .padding(.top, 0) // Pin to absolute top
            
            Spacer() // Push everything to the top of our 400x400 transparent panel
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onHover { hovering in
            if hovering {
                NSHapticFeedbackManager.defaultPerformer.perform(.alignment, performanceTime: .now)
            }
        }
        .onDrop(of: [.fileURL, .text], isTargeted: nil) { providers in
            NSHapticFeedbackManager.defaultPerformer.perform(.generic, performanceTime: .now)
            return ShelfDropManager.shared.handleDrop(providers: providers)
        }
    }
}

struct CollapsedView: View {
    @EnvironmentObject var state: SharedState
    
    var body: some View {
        HStack {
            if state.isPlayingMedia {
                Image(systemName: "waveform")
                    .foregroundColor(.green.opacity(0.8))
                    .font(.system(size: 12))
            } else {
                Image(systemName: "waveform")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            Text(state.currentMediaTitle)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: 140)
            
            Spacer()
            
            Image(systemName: "tray.fill")
                .foregroundColor(.white.opacity(0.8))
                .font(.system(size: 12))
        }
        .padding(.horizontal, 16)
        .frame(height: 36)
    }
}

struct ExpandedView: View {
    @EnvironmentObject var state: SharedState
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Shelf & Clipboard")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.9))
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.32, dampingFraction: 0.75)) {
                        state.isExpanded = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white.opacity(0.6))
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(16)
            
            Divider().background(Color.white.opacity(0.1))
            
            // Content List
            ScrollView {
                VStack(spacing: 8) {
                    if state.droppedFiles.isEmpty && state.clipboardItems.isEmpty {
                        Text("No recent items or files.")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                            .padding(.top, 20)
                    }
                    
                    if !state.clipboardItems.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Clipboard History")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                            
                            ForEach(state.clipboardItems) { item in
                                HStack {
                                    if let image = item.image {
                                        Image(nsImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 40)
                                            .cornerRadius(4)
                                    } else if let content = item.content {
                                        Text(content)
                                            .lineLimit(1)
                                            .font(.system(size: 12))
                                            .foregroundColor(.white.opacity(0.8))
                                            .truncationMode(.tail)
                                    }
                                    
                                    Spacer()
                                    Button(action: {
                                        let pb = NSPasteboard.general
                                        pb.clearContents()
                                        if let image = item.image {
                                            pb.writeObjects([image])
                                        } else if let content = item.content {
                                            pb.setString(content, forType: .string)
                                        }
                                        NSHapticFeedbackManager.defaultPerformer.perform(.generic, performanceTime: .now)
                                    }) {
                                        Image(systemName: "doc.on.doc")
                                            .foregroundColor(.white.opacity(0.6))
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .padding(10)
                                .background(Color.white.opacity(0.05))
                                .cornerRadius(8)
                            }
                        }
                    }

                    if !state.droppedFiles.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Dropped Files")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                                .padding(.top, state.clipboardItems.isEmpty ? 0 : 10)
                            
                            ForEach(state.droppedFiles, id: \.self) { url in
                                HStack {
                                    Image(nsImage: NSWorkspace.shared.icon(forFile: url.path))
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text(url.lastPathComponent)
                                        .font(.system(size: 12))
                                        .foregroundColor(.white.opacity(0.8))
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    Spacer()
                                }
                                .padding(10)
                                .background(Color.white.opacity(0.05))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(16)
            }
        }
        .frame(height: 320)
    }
}
