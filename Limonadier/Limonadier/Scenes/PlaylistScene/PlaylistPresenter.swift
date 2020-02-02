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
    //case success
}

class  PlaylistPresenter {
    private let bag = DisposeBag()
    ///Use the scheduler for debouce, Throttle, etc. The scheduler can be set in the constructor to facilitate tests.
    // private let scheduler: SchedulerType
     
    private let router: PlaylistRouterInput
    private weak var viewController: PlaylistIntent?
    private var routePublisher = PublishSubject<PlaylistRoute>()
    private let getPlaylistUC = UseCaseFactory.instance.createUseCase(Domain.GetPlaylistUseCase.self)
    
    init(router: PlaylistRouterInput, viewController: PlaylistIntent) {
        self.router = router
        self.viewController = viewController
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func loadPlaylist()-> Observable<Playlist> {
        self.viewController?.display(viewModel: .loading)
        return getPlaylistUC.execute(())
    }
    
    
    
    
    func attach(playlistObs: Observable<Playlist>) {
        playlistObs.subscribe(onNext: { (playlist) in
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
