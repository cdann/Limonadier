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
        let items = [
            PlaylistItem(artist: "blabla", duration: 33, title: "blabla rosso", url: URL(string:"https://blabla.com/blabla%20rosso")!),
            PlaylistItem(artist: "le chanteur qui a un nom à rallonge genre vraiment assez long", duration: 33, title: "OhAhOhAhOh", url: URL(string:"https://blabla.com/blabla%20rosso")!),
            PlaylistItem(artist: "le chanteur", duration: 33, title: "un titre long, un titre vrqimnet long, un titre long sur plusieurs lignes", url: URL(string:"https://blabla.com/blabla%20rosso")!)
        ]
        return self.requestWithIntervall(Playlist(items: items, readingIndex: 1, readDuration: 20))
        
    }
    
    public func getRessource() -> Observable<String> {
        return self.requestWithIntervall("resource examplee")
    }
    
    func requestWithIntervall<Elem>(_ elem: Elem) -> Observable<Elem>{
        //Observable<Int>.timer(.seconds(2), scheduler: MainScheduler.instance)
        return Observable<Int>.timer(2.0, scheduler: MainScheduler.instance).map { (_) -> Elem in
            return elem
        }
    }
    
    public init() {}
}
