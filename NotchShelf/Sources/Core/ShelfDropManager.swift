import Cocoa
import UniformTypeIdentifiers

class ShelfDropManager {
    static let shared = ShelfDropManager()
    
    func handleDrop(providers: [NSItemProvider]) -> Bool {
        var handled = false
        for provider in providers {
            if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, error in
                    var loadedURL: URL?
                    if let url = item as? URL {
                        loadedURL = url
                    } else if let data = item as? Data {
                        loadedURL = URL(dataRepresentation: data, relativeTo: nil)
                        if loadedURL == nil {
                            loadedURL = URL(string: String(data: data, encoding: .utf8) ?? "")
                        }
                    }
                    if let url = loadedURL {
                        DispatchQueue.main.async {
                            SharedState.shared.droppedFiles.append(url)
                            // Auto expand when file is dropped
                            SharedState.shared.isExpanded = true
                        }
                    }
                }
                handled = true
            } else if provider.hasItemConformingToTypeIdentifier(UTType.text.identifier) {
                // handle text drop
                handled = true
            }
        }
        return handled
    }
}
