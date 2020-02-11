//
//  PlaylistResponse.swift
//  DataLayer
//
//  Created by Céline on 20/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import Domain

public struct PlaylistResponse: Codable {
    struct ReadingResponse: Codable {
        let id: String
        let position: Int
    }
    
    let items: [PlaylistItemResponse]
    let reading : ReadingResponse
}


extension PlaylistResponse {
    func toObject() -> Domain.Playlist {
        let items = self.items.map({ $0.toObject() })
        return Domain.Playlist(items: items, reading: reading.toObject())
    }
}

extension PlaylistResponse.ReadingResponse {
    func toObject() -> Domain.Playlist.Reading {
        return Domain.Playlist.Reading(id: id, position: position)
    }
}
