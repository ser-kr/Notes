//
//  MainViewModel.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import Foundation
class NotesViewModel {
 
    var notes: [Note] = []
    let notesService = PlistNotesService()
    
    func updateNotes() throws {
        self.notes = try notesService.readNotes().notes
    }
    
    func deleteNote(index: Int) throws {
        self.notes.remove(at: index)
        try self.saveNotes()
    }

    
    func addNote(note: Note) {
        self.notes.append(note)
    }
    
    func saveNotes() throws {
        let notes = Notes(notes: self.notes)
        try notesService.saveNotes(notes: notes)  //saveNotes(notes: notes)
    }
    
    func notesNames() -> [String] {
        return self.notes.map { $0.headText }
    }

    
    func filter(text: String) {
        self.notes = self.notes.filter { $0.headText.contains(text) || $0.detailText.contains(text) }
    }
    
}
