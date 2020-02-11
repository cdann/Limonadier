//
//  PlaylistItemResponse.swift
//  Data
//
//  Created by celine dann on 07/12/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import Foundation
import Domain

public struct PlaylistItemResponse: Codable {
    let id: String
    let artist: String
    let duration: Int
    let title: String
    let url: String
}

extension PlaylistItemResponse {
    func toObject() -> Domain.PlaylistItem {
        let itemUrl = URL(string: url)!
        return Domain.PlaylistItem(id: id, artist: artist, duration: duration, title: title, url: itemUrl)
    }
}
