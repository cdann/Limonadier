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
    var testItems: [PlaylistItem] = [
        PlaylistItem(id: "ooo", artist: "blabla", duration: 33, title: "blabla rosso", url: URL(string:"https://blabla.com/blabla%20rosso")!),
        PlaylistItem(id: "ooo2",artist: "lechanteurquiaunnomàrallongegenre vraimentassezlong", duration: 123, title: "OhAhOhAhOh", url: URL(string:"https://blabla.com/blabla%20rosso")!),
        PlaylistItem(id: "ooo3",artist: "le chanteur", duration: 487, title: "un titre long, un titre vrqimnet long, un titre long sur plusieurs lignes", url: URL(string:"https://blabla.com/blabla%20rosso")!)
    ]
    
    var reading: Playlist.Reading = Playlist.Reading(id:"ooo2", position: 13)
    
    public func postUrlItem(url: URL) -> Observable<PlaylistItem> {
        let item = PlaylistItem(id: "plop34\(url.absoluteString)", artist: "The Artist", duration: 33, title: url.absoluteString, url: url)
        testItems.append(item)
        
        return self.requestWithIntervall(item)
    }
    
    public func getPlaylist() -> Observable<Playlist> {
        return self.requestWithIntervall(Playlist(items: testItems,reading: reading))
        
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
