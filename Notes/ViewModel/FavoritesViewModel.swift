//
//  FavoritesViewModel.swift
//  Notes
//
//  Created by SK on 24.12.2021.
//

import Foundation
class FaviritesViewModel {
    
    var notes: [Note] = []
    let notesService = PlistNotesService.instance

    func updateNotes() throws {
        
        self.notes = try notesService.readNotes().notes
        self.notes = self.notes.filter { $0.favorites }
    }
    
    func togleFavorite(index: Int) {
       // self.notes[index].favorites.toggle()
      //  try! self.saveNotes()
    }

    func saveNotes() throws {
       // let notes = Notes(notes: self.notes)
      //  try notesService.saveNotes(notes: notes)
    }
    
    
}
