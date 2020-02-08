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
        playListRows = playlist.map({ (playlist) -> [PlaylistRow] in
            return playlist.items.enumerated().map {
                (index, item) -> PlaylistRow in
                if index == playlist.readingIndex {
                    return .reading(item)
                }
                return index > playlist.readingIndex ? .toRead(item) : .past(item)
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
        playListRows.subscribe(onNext: { (rows) in
            print("YEPP")
            self.viewController?.display(viewModel: .display(rows))
        }, onError: { (error) in
            print("error")
            self.viewController?.display(viewModel: .error(title: "Playlist cannot be loaded", subTitle: error.localizedDescription))
        }, onCompleted: {
            print("completed")
        }).disposed(by: self.bag)
    }
    
}
