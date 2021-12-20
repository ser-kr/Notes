//
//  FavoritesViewModel.swift
//  Notes
//
//  Created by SK on 24.12.2021.
//

import Foundation
class FaviritesViewModel {
    
    var allNotes: Notes
    var shownNotes: [Note] = []
    
    let notesService = PlistNotesService.instance
    
    init() {
        self.allNotes = try! notesService.readNotes()
        self.updateModel()
    }
    
    func deleteFromFavorites(index: Int) {
        self.shownNotes[index].favorites = false
        self.shownNotes.remove(at: index)
        try! self.notesService.saveNotes()
    }
    func updateModel() {
        self.shownNotes = self.allNotes.notes.filter { $0.favorites }
    }
    func saveNotes() throws {
        try! self.notesService.saveNotes()
    }
}
