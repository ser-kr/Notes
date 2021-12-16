//
//  PlistFileManager.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import Foundation
class PlistFileManager {
    
    var tempDir = URL(fileURLWithPath: NSTemporaryDirectory())
    let fileManager = FileManager.default
    
    init(folderName: String) throws {
        tempDir.appendPathComponent(folderName)
        
        let dirExists = fileManager.existence(atUrl: tempDir)
        if dirExists != .directory {
            try fileManager.createDirectory(at: tempDir, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    func writeDataToFile(name: String, data: Data) throws {
        let result = tempDir.appendingPathComponent(name)
        print("path \(result)")

        try data.write(to: result)
    }
    
    func readData(name: String) throws -> Data  {
        let fileURL = tempDir.appendingPathComponent(name)
        return try Data(contentsOf: fileURL)
    }
    
}
public enum FileExistence: Equatable {
    case none
    case file
    case directory
}
public extension FileManager {
    func existence(atUrl url: URL) -> FileExistence {
        var isDirectory: ObjCBool = false
        let exists = self.fileExists(atPath: url.path, isDirectory: &isDirectory)
        
        switch (exists, isDirectory.boolValue) {
        case (false, _): return .none
        case (true, false): return .file
        case (true, true): return .directory
        }
    }
}
