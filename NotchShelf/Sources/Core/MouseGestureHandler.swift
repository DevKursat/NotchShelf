import Cocoa
import SwiftUI

class MouseGestureHandler {
    static let shared = MouseGestureHandler()
    
    private var localMonitor: Any?
    
    func setupMonitors(for window: NSWindow) {
        syncSystemState()
        localMonitor = NSEvent.addLocalMonitorForEvents(matching: [.scrollWheel, .rightMouseDown, .leftMouseDown]) { event in
            guard let view = window.contentView else { return event }
            let locationInWindow = event.locationInWindow
            let bounds = view.bounds
            
            // If event occurs within our transparent window bounds
            if bounds.contains(locationInWindow) {
                
                if event.type == .rightMouseDown {
                    self.showContextMenu(event: event, view: view)
                    return nil
                }
                
                if event.type == .scrollWheel {
                    self.handleScroll(event: event)
                    return nil
                }
                
                if event.type == .leftMouseDown {
                    if event.clickCount == 2 {
                        self.handleDoubleClick()
                        return nil
                    }
                }
            }
            return event
        }
    }
    
    private func handleScroll(event: NSEvent) {
        let deltaY = event.scrollingDeltaY
        let deltaX = event.scrollingDeltaX
        
        DispatchQueue.main.async {
            let state = SharedState.shared
            if abs(deltaY) > abs(deltaX) {
                // Vertical scrolling: volume adjust
                state.currentVolume = max(0.0, min(1.0, state.currentVolume + Float(deltaY) * 0.01))
                self.setSystemVolume(state.currentVolume)
            } else {
                // Horizontal scrolling: Brightness
                state.currentBrightness = max(0.0, min(1.0, state.currentBrightness + Float(deltaX) * 0.01))
                if abs(deltaX) > 0.5 {
                    self.adjustBrightness(up: deltaX > 0)
                }
            }
        }
    }
    
    private func setSystemVolume(_ volume: Float) {
        let script = "set volume output volume \(Int(volume * 100))"
        DispatchQueue.global(qos: .userInitiated).async {
            var error: NSDictionary?
            if let appleScript = NSAppleScript(source: script) {
                appleScript.executeAndReturnError(&error)
            }
        }
    }
    
    func syncSystemState() {
        DispatchQueue.global(qos: .userInitiated).async {
            var error: NSDictionary?
            if let appleScript = NSAppleScript(source: "output volume of (get volume settings)") {
                let descriptor = appleScript.executeAndReturnError(&error)
                if error == nil, let volString = descriptor.stringValue, let volInt = Int(volString) {
                    DispatchQueue.main.async {
                        SharedState.shared.currentVolume = Float(volInt) / 100.0
                    }
                } else if error == nil {
                    let volInt = Int(descriptor.int32Value)
                    DispatchQueue.main.async {
                        SharedState.shared.currentVolume = Float(volInt) / 100.0
                    }
                }
            }
        }
    }
    
    private func adjustBrightness(up: Bool) {
        let keyCode = up ? 144 : 145
        let script = "tell application \"System Events\" to key code \(keyCode)"
        DispatchQueue.global(qos: .userInitiated).async {
            var error: NSDictionary?
            if let appleScript = NSAppleScript(source: script) {
                appleScript.executeAndReturnError(&error)
            }
        }
    }
    
    private func handleDoubleClick() {
        NSHapticFeedbackManager.defaultPerformer.perform(.generic, performanceTime: .now)
        DispatchQueue.main.async {
            withAnimation(.spring(response: 0.32, dampingFraction: 0.75)) {
                SharedState.shared.isExpanded.toggle()
            }
        }
    }
    
    private func showContextMenu(event: NSEvent, view: NSView) {
        NSHapticFeedbackManager.defaultPerformer.perform(.generic, performanceTime: .now)
        let menu = NSMenu(title: "Notch Actions")
        menu.addItem(withTitle: "Pano Geçmişini Temizle", action: #selector(clearClipboard), keyEquivalent: "")
        menu.addItem(withTitle: "Rafı Boşalt", action: #selector(clearShelf), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Ayarlar", action: #selector(openSettings), keyEquivalent: ",")
        menu.addItem(withTitle: "Çıkış", action: #selector(quitApp), keyEquivalent: "q")
        
        menu.items.forEach { $0.target = self }
        NSMenu.popUpContextMenu(menu, with: event, for: view)
    }
    
    @objc func clearClipboard() {
        SharedState.shared.clipboardItems.removeAll()
    }
    
    @objc func clearShelf() {
        SharedState.shared.droppedFiles.removeAll()
    }
    
    @objc func openSettings() {
        // Implementation for opening settings
    }
    
    @objc func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}
