//
//  PlaylistItem.swift
//  Domain
//
//  Created by celine dann on 07/12/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import Foundation

public struct PlaylistItem {
    let artist: String
    let duration: Int
    let title: String
    let url: URL
    
    public init(artist: String, duration: Int, title: String, url: URL) {
        self.artist = artist
        self.duration = duration
        self.title = title
        self.url = url
    }
}
