//
//  MainViewPresenter.swift
//  RxSample
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright (c) 2019 mstv. All rights reserved.
//
//

import Foundation
import RxSwift
import Domain

enum MainViewModel {
    case display
}

class  MainViewPresenter {
    private let bag = DisposeBag()
    
    private let router: MainViewRouterInput
    private weak var viewController: MainViewIntents?
    //private var routePublisher = PublishSubject<MainViewRoute>()
    
    private let getPlaylistUC = UseCaseFactory.instance.createUseCase(Domain.GetPlaylistUseCase.self)
    
    let playlistChanged: PublishSubject<Playlist> = PublishSubject()
    let needToLoadPlaylist: PublishSubject<Void> = PublishSubject()
    
    init(router: MainViewRouterInput,
         viewController: MainViewIntents) {
        self.router = router
        self.viewController = viewController
    }
    
    
    deinit {
        print("Deinit \(self)")
    }
    
    
    
    func attach() {
        self.needToLoadPlaylist.flatMap({ [weak self] (_) -> Observable<Playlist> in
            guard let `self` = self else{ return Observable.empty() }
            return self.getPlaylistUC.execute(())
        }).subscribe(self.playlistChanged).disposed(by: bag)
        needToLoadPlaylist.onNext(())
        Observable<Int>.interval(5, scheduler: MainScheduler.instance).map({ _ in () }).bind(to: needToLoadPlaylist.asObserver()).disposed(by: bag)
    }
    func observeRouting(routeEvent: Observable<MainViewRoute>) {
        routeEvent
        .subscribe(onNext: { [weak self] (route) in
            self?.router.go(to: route) })
        .disposed(by: bag)
    }
    
}
