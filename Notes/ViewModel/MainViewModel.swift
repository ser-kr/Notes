//
//  MainViewModel.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import Foundation
import UIKit
class MainViewModel {
    var allNotes: Notes
    var shownNotes: [Note] = []
    
    let notesService = PlistNotesService.instance
    
    init() {
        self.allNotes = try! notesService.readNotes()
        self.shownNotes = allNotes.notes
    }
    
    func deleteNote(index: Int) throws {
        let note = shownNotes[index]
        self.shownNotes.remove(at: index)
        self.allNotes.notes.removeAll(where: {$0 === note} )
        try self.saveNotes()
    }
    func togleFavorite(index: Int) {
        self.shownNotes[index].favorites.toggle()
        try! self.saveNotes()
    }
   
    func addNote(note: Note) {
        self.allNotes.notes.append(note)
        self.shownNotes.append(note)
        try! self.saveNotes()
    }
    
    func saveNotes() throws {
        try! self.notesService.saveNotes()
    }
    
    func filter(text: String) {
        if text.isEmpty {
            self.shownNotes = self.allNotes.notes
        } else {
            self.shownNotes = self.allNotes.notes.filter { $0.headText.contains(text) }
        }
    }
}
