//
//  LocalTestRepository.swift
//  DataLayer
//
//  Created by Céline on 23/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import RxSwift
import Domain

public class LocalTestRepository: Domain.Repository {
    
    public func postUrlItem(url: URL) -> Observable<PlaylistItem> {
        let item = PlaylistItem(artist: "The Artist", duration: 33, title: "The title", url: URL(string:"https://TheArtist.com/title")!)
        return self.requestWithIntervall(item)
    }
    
    public func getPlaylist() -> Observable<Playlist> {
        let playlist = Playlist(items:[
            PlaylistItem(artist: "blabla", duration: 33, title: "blabla rosso", url: URL(string:"https://blabla.com/blabla%20rosso")!),
            PlaylistItem(artist: "le chanteur", duration: 33, title: "OhAhOhAhOh", url: URL(string:"https://blabla.com/blabla%20rosso")!)
        ])
        return self.requestWithIntervall(playlist)
        
    }
    
    public func getRessource() -> Observable<String> {
        return self.requestWithIntervall("resource examplee")
    }
    
    func requestWithIntervall<Elem>(_ elem: Elem) -> Observable<Elem>{
        return Observable<Int>.timer(.seconds(2), scheduler: MainScheduler.instance).map { (_) -> Elem in
            return elem
        }
    }
    
    public init() {}
}