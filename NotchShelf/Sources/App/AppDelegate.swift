import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var notchWindowController: NotchWindowController?
    var clipboardManager = ClipboardManager()
    var mediaListener = MediaListener()

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Run as an accessory app (no dock icon)
        NSApp.setActivationPolicy(.accessory)
        
        // Show viral loop alert on first launch
        showViralLoopAlertIfNeeded()
        
        // Initialize the transparent notch panel
        notchWindowController = NotchWindowController()
        notchWindowController?.showWindow(nil)
        
        // Start listening to clipboard changes in the background
        clipboardManager.startListening()
        
        // Start media listener
        mediaListener.start()
    }
    
    private func showViralLoopAlertIfNeeded() {
        let defaults = UserDefaults.standard
        let hasStarred = defaults.bool(forKey: "hasStarredRepo")
        let hasFollowed = defaults.bool(forKey: "hasFollowedDev")
        
        if hasStarred && hasFollowed {
            return
        }
        
        let alert = NSAlert()
        alert.messageText = "Unlock NotchShelf! 🚀"
        alert.informativeText = "To unlock and use this amazing tool, please support us by starring our GitHub repository and following the developer!"
        alert.alertStyle = .informational
        
        if !hasStarred {
            alert.addButton(withTitle: "1. Star Repository ⭐️")
        }
        if !hasFollowed {
            alert.addButton(withTitle: "2. Follow Developer 👨‍💻")
        }
        
        alert.addButton(withTitle: "Quit")
        
        // Bring app to front so alert is visible
        NSApp.activate(ignoringOtherApps: true)
        
        let response = alert.runModal()
        
        if response == .alertFirstButtonReturn {
            if !hasStarred {
                if let url = URL(string: "https://github.com/DevKursat/NotchShelf") {
                    NSWorkspace.shared.open(url)
                }
                defaults.set(true, forKey: "hasStarredRepo")
                DispatchQueue.main.async { self.showViralLoopAlertIfNeeded() }
            } else if !hasFollowed {
                if let url = URL(string: "https://github.com/DevKursat") {
                    NSWorkspace.shared.open(url)
                }
                defaults.set(true, forKey: "hasFollowedDev")
                DispatchQueue.main.async { self.showViralLoopAlertIfNeeded() }
            }
        } else if response == .alertSecondButtonReturn {
            if !hasStarred && !hasFollowed {
                if let url = URL(string: "https://github.com/DevKursat") {
                    NSWorkspace.shared.open(url)
                }
                defaults.set(true, forKey: "hasFollowedDev")
                DispatchQueue.main.async { self.showViralLoopAlertIfNeeded() }
            } else {
                NSApp.terminate(nil)
            }
        } else {
            NSApp.terminate(nil)
        }
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        clipboardManager.stopListening()
        mediaListener.stop()
    }
}
