//
//  Playlist.swift
//  Domain
//
//  Created by Céline on 20/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation

public struct Playlist {
    
    public struct Reading {
        public let id: String
        public let position: Int
        
        public init(id: String, position: Int) {
            self.id = id
            self.position = position
        }
    }
    
    public let items: [PlaylistItem]
    public let reading: Reading
    
    
    public init(items: [PlaylistItem], reading: Reading) {
        self.items = items
        self.reading = reading
    }
}
