import Foundation

extension FileManager {

    var documentDirectory: URL? {
        urls(for: .documentDirectory, in: .userDomainMask).first
    }

    func copyItemToDocumentDirectory(from sourceURL: URL) -> URL? {
        guard let documentDirectory = documentDirectory else { return nil }
        
        let fileName = sourceURL.lastPathComponent
        let destinationURL = documentDirectory.appendingPathComponent(fileName)
        if fileExists(atPath: destinationURL.path) {
            return destinationURL
        }
    
        do {
            try copyItem(at: sourceURL, to: destinationURL)
            return destinationURL
        } catch {
            print("Unable to copy file: \(error.localizedDescription)")
            return nil
        }
    }

    func removeItemFromDocumentDirectory(url: URL) {
        guard let documentDirectory = documentDirectory else { return }
        
        let fileName = url.lastPathComponent
        let fileUrl = documentDirectory.appendingPathComponent(fileName)
        if fileExists(atPath: fileUrl.path) {
            do {
                try removeItem(at: url)
            } catch {
                print("Unable to remove file: \(error.localizedDescription)")
            }
        }
    }

    func getContentsOfDirectory(_ url: URL) -> [URL] {
        var isDirectory: ObjCBool = false
        // The URL must be a directory.
        guard FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory), isDirectory.boolValue else { return [] }
        
        do {
            return try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        } catch {
            print("Unable to get directory contents: \(error.localizedDescription)")
            return []
        }
    }
}
