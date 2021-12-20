//
//  PlistService.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import Foundation


class PlistNotesService {
    static var instance = PlistNotesService()
    var plistManager: PlistFileManager
    var notes: Notes? = nil
    let fileName = "Notes.plist"
    private init() {
        do {
            plistManager =  try PlistFileManager(folderName: "NotesFolder")
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
    
    func readNotes() throws -> Notes {
        if notes == nil {
            let data = try plistManager.readData(name: fileName)
            self.notes = try PropertyListDecoder().decode(Notes.self, from: data)
        }
        return notes!
    }
    
    func saveNotes() throws {
        let notesData = try PropertyListEncoder().encode(self.notes)
        try plistManager.writeDataToFile(name: fileName, data: notesData)
    }
}
