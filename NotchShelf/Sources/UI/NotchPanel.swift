import Cocoa

class NotchPanel: NSPanel {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        
        // Appear on all workspaces and float above other windows
        self.level = .mainMenu + 1 // Right below or above status bar items
        self.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .stationary, .ignoresCycle]
        
        // Transparency and clear background
        self.backgroundColor = .clear
        self.isOpaque = false
        self.hasShadow = false
        
        // Mouse and dragging capabilities
        self.ignoresMouseEvents = false
        self.acceptsMouseMovedEvents = true
        self.isMovableByWindowBackground = false
        
        // Register drag types that we support
        self.registerForDraggedTypes([.fileURL, .string, .tiff, .png])
    }
    
    // Allow panel to become key so we can type if needed (e.g. search)
    override var canBecomeKey: Bool { return true }
    override var canBecomeMain: Bool { return true }
}
