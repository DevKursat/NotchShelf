import Foundation

let script = """
return {false, "NotchShelf - Idle"}
"""
var error: NSDictionary?
if let appleScript = NSAppleScript(source: script) {
    let descriptor = appleScript.executeAndReturnError(&error)
    print(descriptor.atIndex(1)?.booleanValue ?? "nil1")
    print(descriptor.atIndex(2)?.stringValue ?? "nil2")
}
