//
//  PlayerPresenter.swift
//  limonadier
//
//  Created by celine dann on 11/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Domain

enum PlayerModel {
    case loading
    case display(readingTrack: PlaylistItem, readingPosition:Int)
    case error(title: String, subtitle: String)
}

class PlayerPresenter {

    private let bag = DisposeBag()
    private let router: PlayerRouterInput
    private weak var viewController: PlayerIntents?
    private var routePublisher = PublishSubject<PlayerRoute>()
    private let playlistReading: Observable<(readingPosition: Int, readingTrack: PlaylistItem?)>
     private let onPlaylistNeedLoading: PublishSubject<Void>
    

    init(router: PlayerRouterInput,
         viewController: PlayerIntents, playlist: Observable<Playlist>, onPlaylistNeedLoading: PublishSubject<Void>) {
        self.router = router
        self.viewController = viewController
        self.playlistReading = playlist.map({ (playlist) -> (readingPosition: Int, readingTrack: PlaylistItem?) in
            let readingPosition = playlist.reading.position
            let readingTrack = playlist.items.first { (item) -> Bool in
                return item.id == playlist.reading.id
                }
            return (readingPosition: readingPosition, readingTrack: readingTrack)
        })
        self.onPlaylistNeedLoading = onPlaylistNeedLoading
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func needToReloadPlayingTrack() {
        onPlaylistNeedLoading.onNext(())
    }
    
    func attach() {
        guard let viewController = viewController else { return }
        
        playlistReading.debug("reading").subscribe(onNext: {
            (readingData) in
            guard let track = readingData.readingTrack else {
                return
            }
            viewController.display(viewModel: .display(readingTrack: track, readingPosition: readingData.readingPosition))
            }, onError: { (error) in
                // viewController.display(viewModel: .error(error.localizedDescription))
            }).disposed(by: bag)
        
        routePublisher
            .subscribe(onNext: { [weak self] (route) in
                self?.router.go(to: route) })
            .disposed(by: bag)
    }
    
}
