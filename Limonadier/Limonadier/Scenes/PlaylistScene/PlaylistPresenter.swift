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
    case display(playlist: Playlist)
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
        return getPlaylistUC.execute(())
        //return Observable.timer(3.0, scheduler: MainScheduler.instance).take(3)
    }
    
    
    
    
    func attach(playlistObs: Observable<Playlist>) {
        guard let viewController = viewController else { return }
//        viewController.display(viewModel: .loading)
        playlistObs.subscribe(onNext: { (playlist) in
            print("YEPP")
            self.viewController?.display(viewModel: .display(playlist: playlist))
        }, onError: { (error) in
            print("error")
            self.viewController?.display(viewModel: .error(title: "Playlist cannot be loaded", subTitle: error.localizedDescription))
        }, onCompleted: {
            print("completed")
        }).disposed(by: self.bag)
        
        //self.observeRouting(routeEvent: routePublisher.asObservable())
        
        
//        let loadIntent = viewController.loadIntent()
//            .map { playlist in PlaylistModel.display(playlist: playlist) }
//            .startWith(.loading)
//            .catchError({ (error) -> Observable<PlaylistModel> in
//                return Observable.just(PlaylistModel.error(title: error.localizedDescription, subTitle: nil))
//            })
            
//        self.observeLoadIntent(loadIntent: loadIntent)
        

    }
    
    func observeLoadIntent(loadIntent: Observable<PlaylistModel>) {
        loadIntent.subscribe(onNext: { [weak self] (model) in
            self?.viewController?.display(viewModel: model)
        }).disposed(by: bag)
    }
    
}
