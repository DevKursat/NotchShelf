import SwiftUI

@main
struct NotchShelfApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // We do not define a WindowGroup here because we manage an NSPanel directly.
        // This ensures no default window is created.
        Settings {
            EmptyView()
        }
    }
}
