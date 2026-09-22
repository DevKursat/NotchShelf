import SwiftUI

class SharedState: ObservableObject {
    static let shared = SharedState()
    
    @Published var isExpanded = false
    @Published var clipboardItems: [ClipboardItem] = []
    @Published var droppedFiles: [URL] = []
    
    // System simulated state
    @Published var currentVolume: Float = 0.5
    @Published var currentBrightness: Float = 0.5
    @Published var isPlayingMedia = false
    @Published var currentMediaTitle = "NotchShelf - Idle"
}

struct ClipboardItem: Identifiable, Equatable {
    let id = UUID()
    let content: String?
    let image: NSImage?
    let date: Date
    
    static func == (lhs: ClipboardItem, rhs: ClipboardItem) -> Bool {
        return lhs.content == rhs.content && lhs.image == rhs.image && lhs.date == rhs.date
    }
}
