//
//  PlistReader.swift
//  Notes
//
//  Created by SK on 16.12.2021.
//

import Foundation
enum PreferencesError: Error {
    case invalidURL
    case invalidFile
}

class PlistEntityReader <T: Codable>  {
    
    func getEntity(name: String) throws -> T {
        guard let path  = Bundle.main.path(forResource: name, ofType: "plist") else {
            throw PreferencesError.invalidURL
        }
        
        guard let xml  = FileManager.default.contents(atPath: path) else {
            throw PreferencesError.invalidFile
        }
            
        let preferences = try PropertyListDecoder().decode(T.self, from: xml)

        return preferences
    
    }
    
}
