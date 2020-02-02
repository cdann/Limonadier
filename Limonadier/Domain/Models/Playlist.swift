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
    
    public init(items: [PlaylistItem]) {
        self.items = items
    }
}
