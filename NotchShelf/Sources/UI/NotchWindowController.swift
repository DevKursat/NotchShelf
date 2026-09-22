import Cocoa
import SwiftUI

class NotchWindowController: NSWindowController {
    
    init() {
        // Create a fixed size bounding box for the notch and its expanded state.
        // The actual visual shape will be drawn by SwiftUI inside this transparent panel.
        let panel = NotchPanel(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 400),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        
        super.init(window: panel)
        
        let contentView = ContentView()
            .environmentObject(SharedState.shared)
        
        panel.contentView = NSHostingView(rootView: contentView)
        
        positionPanel()
        MouseGestureHandler.shared.setupMonitors(for: panel)
        
        // Listen to screen changes
        NotificationCenter.default.addObserver(self, selector: #selector(positionPanel), name: NSApplication.didChangeScreenParametersNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func positionPanel() {
        guard let window = window, let screen = NSScreen.main else { return }
        
        let screenFrame = screen.frame
        let screenVisibleFrame = screen.visibleFrame
        
        // Heuristic: If the visible frame's top is lower than the screen frame's top, there's a menu bar.
        // For Notch Macs, screen.safeAreaInsets.top might be useful on macOS 12+, but let's use geometry.
        let hasNotch = screenFrame.height > screenVisibleFrame.height + 24
        
        let windowWidth = window.frame.width
        let windowHeight = window.frame.height
        
        let xPos = screenFrame.origin.x + (screenFrame.width - windowWidth) / 2
        
        // Pin to the top edge
        let yPos = screenFrame.origin.y + screenFrame.height - windowHeight
        
        // We set the panel right at the top. 
        // The SwiftUI view will align its contents to the `.top` to emulate the notch.
        window.setFrameOrigin(NSPoint(x: xPos, y: yPos))
    }
}
