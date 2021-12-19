//
//  PlistService.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import Foundation
class PlistNotesService {
    
    var plistManager: PlistFileManager
    let fileName = "Notes.plist"
    init() {
        do {
            plistManager =  try PlistFileManager(folderName: "NotesFolder")
        } catch {
            print("ZZZ")
            fatalError(error.localizedDescription)
            
        }
    }
    
    func readNotes() throws -> Notes {
        let data = try plistManager.readData(name: fileName)
        let notes = try PropertyListDecoder().decode(Notes.self, from: data)
        return notes
    }
    
    func saveNotes(notes: Notes) throws {
       let notesData = try PropertyListEncoder().encode(notes)
       try plistManager.writeDataToFile(name: fileName, data: notesData)
    }
    
    
}
