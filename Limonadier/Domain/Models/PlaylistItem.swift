//
//  PlaylistItem.swift
//  Domain
//
//  Created by celine dann on 07/12/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import Foundation

public struct PlaylistItem {
    public let artist: String
    public let duration: Int
    public let title: String
    public let url: URL
    
    public init(artist: String, duration: Int, title: String, url: URL) {
        self.artist = artist
        self.duration = duration
        self.title = title
        self.url = url
    }
}
