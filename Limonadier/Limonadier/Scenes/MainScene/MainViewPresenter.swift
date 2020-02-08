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
    private var routePublisher = PublishSubject<MainViewRoute>()
    
    private let getPlaylistUC = UseCaseFactory.instance.createUseCase(Domain.GetPlaylistUseCase.self)
    
    let playlist: Observable<Playlist>
    
    init(router: MainViewRouterInput,
         viewController: MainViewIntents) {
        self.router = router
        self.viewController = viewController
        self.playlist = Observable<Int>.interval(5, scheduler: MainScheduler.instance).flatMap { [getPlaylistUC] (_) -> Observable<Playlist> in
            return getPlaylistUC.execute(()).debug()
        }
    }
    
    
    deinit {
        print("Deinit \(self)")
    }
    
    
    
    func attach() {
        self.observeRouting(routeEvent: routePublisher.asObservable())

    }
    func observeRouting(routeEvent: Observable<MainViewRoute>) {
        routeEvent
        .subscribe(onNext: { [weak self] (route) in
            self?.router.go(to: route) })
        .disposed(by: bag)
    }
    
}
