import Cocoa

class MediaListener {
    func start() {
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(playbackStateChanged(_:)), name: NSNotification.Name("com.spotify.client.PlaybackStateChanged"), object: nil)
        DistributedNotificationCenter.default().addObserver(self, selector: #selector(playbackStateChanged(_:)), name: NSNotification.Name("com.apple.Music.playerInfo"), object: nil)
        
        // We can do an initial check via AppleScript to get the current state if it's already playing.
        checkMedia()
    }
    
    func stop() {
        DistributedNotificationCenter.default().removeObserver(self)
    }
    
    @objc private func playbackStateChanged(_ notification: Notification) {
        checkMedia()
    }
    
    private func checkMedia() {
        let script = """
        set mediaTitle to "NotchShelf - Idle"
        set isPlaying to false

        try
            if application "Spotify" is running then
                tell application "Spotify"
                    if player state is playing then
                        set mediaTitle to (get name of current track) & " - " & (get artist of current track)
                        set isPlaying to true
                    end if
                end tell
            else if application "Music" is running then
                tell application "Music"
                    if player state is playing then
                        set mediaTitle to (get name of current track) & " - " & (get artist of current track)
                        set isPlaying to true
                    end if
                end tell
            end if
        end try

        return {isPlaying, mediaTitle}
        """
        
        DispatchQueue.global(qos: .userInitiated).async {
            var error: NSDictionary?
            if let appleScript = NSAppleScript(source: script) {
                let descriptor = appleScript.executeAndReturnError(&error)
                if error == nil {
                    let playingDesc = descriptor.atIndex(1)
                    let titleDesc = descriptor.atIndex(2)
                    let playing = playingDesc?.booleanValue ?? false
                    let title = titleDesc?.stringValue ?? "NotchShelf - Idle"
                    
                    DispatchQueue.main.async {
                        SharedState.shared.isPlayingMedia = playing
                        SharedState.shared.currentMediaTitle = title
                    }
                }
            }
        }
    }
}
