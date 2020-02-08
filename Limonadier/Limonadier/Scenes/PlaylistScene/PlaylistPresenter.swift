//
//  PlaylistPresenter.swift
//  Domain
//
//  Created by Céline on 20/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import RxSwift
import Domain

enum PlaylistModel {
    case loading
    case display
    case error(title:String, subTitle: String?)
}

class  PlaylistPresenter {
    private let bag = DisposeBag()
    private let router: PlaylistRouterInput
    private weak var viewController: PlaylistIntent?
    private var routePublisher = PublishSubject<PlaylistRoute>()
    var playListSectionsObs: Observable<[PlaylistRow]>
    
    init(router: PlaylistRouterInput, viewController: PlaylistIntent, playlistObservable:  Observable<Playlist>) {
        self.router = router
        self.viewController = viewController
        playListSectionsObs = playlistObservable.map({ (playlist) -> [PlaylistRow] in
            return playlist.items.enumerated().map {
                (index, item) -> PlaylistRow in
                if index == playlist.readingIndex {
                    return .reading(item)
                }
                return index > playlist.readingIndex ? .toRead(item) : .past(item)
            }
        })
        subscribeViewModel()
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func subscribeViewModel() {
        self.viewController?.display(viewModel: .loading)
        playListSectionsObs.subscribe(onNext: { (playlist) in
            print("YEPP \(playlist)")
            self.viewController?.display(viewModel: .display)
        }, onError: { (error) in
            print("error")
            self.viewController?.display(viewModel: .error(title: "Playlist cannot be loaded", subTitle: error.localizedDescription))
        }, onCompleted: {
            print("completed")
        }).disposed(by: self.bag)
    }
    
    func observeLoadIntent(loadIntent: Observable<PlaylistModel>) {
        loadIntent.subscribe(onNext: { [weak self] (model) in
            self?.viewController?.display(viewModel: model)
        }).disposed(by: bag)
    }
    
}
