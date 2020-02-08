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
    let items: [PlaylistItemResponse]
    let idx: Int
}


extension PlaylistResponse {
    func toObject() -> Domain.Playlist {
        let items = self.items.map({ $0.toObject() })
        return Domain.Playlist(items: items, readingIndex: idx)
    }
}
