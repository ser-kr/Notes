//
//  ViewModel.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import Foundation
class AddNoteViewModel {
    
    var note = Note()
    
    func editNotesPic(url: URL?) {
        self.note.attachImage = url
    }
}
