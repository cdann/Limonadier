//
//  Playlist.swift
//  Domain
//
//  Created by Céline on 20/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation

public struct Playlist {
    public let items: [PlaylistItem]
    
    //temporary property
    public let readingIndex: Int
    public let readDuration: Int
    
    public init(items: [PlaylistItem], readingIndex: Int = 0, readDuration: Int = 0) {
        self.items = items
        self.readDuration = readDuration
        self.readingIndex = readingIndex
    }
}
