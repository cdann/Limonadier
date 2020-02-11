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
    case display([PlaylistRow])
    case error(title:String, subTitle: String?)
}

class  PlaylistPresenter {
    let bag = DisposeBag()
    private let router: PlaylistRouterInput
    private weak var viewController: PlaylistIntent?
    private var routePublisher = PublishSubject<PlaylistRoute>()
    var playListRows: Observable<[PlaylistRow]>
    
    init(router: PlaylistRouterInput, viewController: PlaylistIntent, playlist:  Observable<Playlist>) {
        self.router = router
        self.viewController = viewController
        var afterCurrent = false
        playListRows = playlist.map({ (playlist) -> [PlaylistRow] in
            return playlist.items.map {
                (item) -> PlaylistRow in
                if item.id == playlist.reading.id {
                    afterCurrent = true
                    return .reading(item)
                }
                return afterCurrent ? .toRead(item) : .past(item)
            }
        })
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func attach(){
        subscribeViewModel()
    }
    
    func subscribeViewModel() {
        self.viewController?.display(viewModel: .loading)
        playListRows.debug("didChange").subscribe(onNext: { (rows) in
            self.viewController?.display(viewModel: .display(rows))
        }, onError: { (error) in
            self.viewController?.display(viewModel: .error(title: "Playlist cannot be loaded", subTitle: error.localizedDescription))
        }, onCompleted: {
        }).disposed(by: self.bag)
    }
    
}
