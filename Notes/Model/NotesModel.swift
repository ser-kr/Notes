//
//  File.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import Foundation
import UIKit

struct Note: Codable {
    var headText: String
    var detailText: String
    var favorites: Bool
    var attachImage: URL?
    
    static var initial = Note(headText: "", detailText: "", favorites: false)
}

struct Notes: Codable {
    var notes: [Note]
}

// Add Notes View Model

class AddNoteViewModel {
    
    var notes = Note.initial
    
    func editNotesPic(url: URL?) {
        self.notes.attachImage = url
    }
}
