import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var notchWindowController: NotchWindowController?
    var clipboardManager = ClipboardManager()
    var mediaListener = MediaListener()

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Run as an accessory app (no dock icon)
        NSApp.setActivationPolicy(.accessory)
        
        // Initialize the transparent notch panel
        notchWindowController = NotchWindowController()
        notchWindowController?.showWindow(nil)
        
        // Start listening to clipboard changes in the background
        clipboardManager.startListening()
        
        // Start media listener
        mediaListener.start()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        clipboardManager.stopListening()
        mediaListener.stop()
    }
}
