//
//  File.swift
//  Notes
//
//  Created by SK on 06.12.2021.
//

import Foundation
import UIKit

class Note: Codable {
    var headText: String
    var detailText: String
    var favorites: Bool
    var attachImage: URL?
    init() {
        self.headText = ""
        self.detailText = ""
        self.favorites = false
        self.attachImage = nil
    }
}

class Notes: Codable {
    var notes: [Note]
}



