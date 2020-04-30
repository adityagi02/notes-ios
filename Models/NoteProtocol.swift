//
//  NoteProtocol.swift
//  iOCNotes
//
//  Created by Peter Hedlund on 6/16/18.
//  Copyright © 2018 Peter Hedlund. All rights reserved.
//

import Foundation

protocol NoteProtocol {
    
    var category: String {get set}
    var content: String {get set}
    var favorite: Bool {get set}
    var guid: String? {get set}
    var modified: TimeInterval {get set}
    var id: Int64 {get set}
    var title: String {get set}
    var errorMessage: String? {get set}
    var error: Bool {get set}
    var etag: String {get set}
    var addNeeded: Bool {get set}
    var deleteNeeded: Bool {get set}
    var updateNeeded: Bool {get set}

}

struct NoteStruct: Codable, NoteProtocol {
    
    var category: String
    var content: String
    var favorite: Bool
    var guid: String?
    var modified: TimeInterval
    var id: Int64
    var title: String
    var errorMessage: String?
    var error: Bool
    var etag: String
    var addNeeded: Bool
    var deleteNeeded: Bool
    var updateNeeded: Bool

    enum CodingKeys: String, CodingKey {
        case category = "category"
        case content = "content"
        case favorite = "favorite"
        case guid = "guid"
        case modified = "modified"
        case id = "id"
        case title = "title"
        case errorMessage = "errorMessage"
        case error = "error"
        case etag = "etag"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category) ?? ""
        content = try values.decode(String.self, forKey: .content)
        favorite = try values.decode(Bool.self, forKey: .favorite)
        guid = try values.decodeIfPresent(String.self, forKey: .guid)
        modified = try values.decode(TimeInterval.self, forKey: .modified)
        id = try values.decode(Int64.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        error = try values.decodeIfPresent(Bool.self, forKey: .error) ?? false
        etag = try values.decodeIfPresent(String.self, forKey: .etag) ?? ""
        addNeeded = false
        deleteNeeded = false
        updateNeeded = false
    }

    init(content: String, category: String, favorite: Bool = false) {
        self.content = content
        title = NSLocalizedString("New note", comment: "The title of a new note")
        self.category = category
        self.favorite = favorite
        guid = UUID().uuidString
        modified = Date().timeIntervalSince1970
        id = -1
        etag = ""
        error = false
        addNeeded = true
        deleteNeeded = false
        updateNeeded = false
    }
}
