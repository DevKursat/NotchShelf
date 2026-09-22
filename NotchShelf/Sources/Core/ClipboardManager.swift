import Cocoa

class ClipboardManager {
    private let pasteboard = NSPasteboard.general
    private var lastChangeCount = 0
    private var timer: Timer?
    
    func startListening() {
        lastChangeCount = pasteboard.changeCount
        // Poll for clipboard changes.
        // A more advanced approach uses a custom NSApplication runloop, but polling is lightweight and standard for simple clipboard history.
        timer = Timer.scheduledTimer(withTimeInterval: 0.75, repeats: true) { [weak self] _ in
            self?.checkPasteboard()
        }
    }
    
    private func checkPasteboard() {
        guard pasteboard.changeCount != lastChangeCount else { return }
        lastChangeCount = pasteboard.changeCount
        
        var stringContent: String?
        var imageContent: NSImage?
        
        if let tiffData = pasteboard.data(forType: .tiff), let image = NSImage(data: tiffData) {
            imageContent = image
        } else if let pngData = pasteboard.data(forType: .png), let image = NSImage(data: pngData) {
            imageContent = image
        } else if let images = pasteboard.readObjects(forClasses: [NSImage.self], options: nil) as? [NSImage], let image = images.first {
            imageContent = image
        } else if let string = pasteboard.string(forType: .string) {
            stringContent = string
        }
        
        guard stringContent != nil || imageContent != nil else { return }
        
        DispatchQueue.main.async {
            let item = ClipboardItem(content: stringContent, image: imageContent, date: Date())
            
            // Avoid consecutive duplicates
            if let first = SharedState.shared.clipboardItems.first {
                let isDuplicateString = (stringContent != nil && first.content == stringContent)
                let isDuplicateImage = (imageContent != nil && first.image?.size == imageContent?.size)
                if isDuplicateString || isDuplicateImage {
                    return
                }
            }
            
            SharedState.shared.clipboardItems.insert(item, at: 0)
            if SharedState.shared.clipboardItems.count > 15 {
                SharedState.shared.clipboardItems.removeLast()
            }
        }
    }
    
    func stopListening() {
        timer?.invalidate()
        timer = nil
    }
}
