//
//  PlaylistViewPresenter.swift
//  RxSample
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright (c) 2019 mstv. All rights reserved.
//
//

import Foundation
import RxSwift
import Domain

enum PlaylistViewModel {
    case loading
    case display
    case error(title:String, subTitle: String?)
    case success
}

class  PlaylistViewPresenter {
    private let bag = DisposeBag()
    ///Use the scheduler for debouce, Throttle, etc. The scheduler can be set in the constructor to facilitate tests.
   // private let scheduler: SchedulerType
    
    private let router: PlaylistViewRouterInput
    private weak var viewController: PlaylistViewIntents?
    private var routePublisher = PublishSubject<PlaylistViewRoute>()
    private let postURLUC = UseCaseFactory.instance.createUseCase(PostPlaylistUrlUseCase.self)
    
    init(router: PlaylistViewRouterInput,
         viewController: PlaylistViewIntents) {
        self.router = router
        self.viewController = viewController
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func loadThings()-> Observable<Int> {
        return Observable.timer(3.0, scheduler: PlaylistScheduler.instance).take(3)
    }
    
    
    
    
    func attach() {
        guard let viewController = viewController else { return }
        
        self.observeRouting(routeEvent: routePublisher.asObservable())
        
        let loadIntent = viewController.loadIntent()
            .map { PlaylistViewModel.display }
            .startWith(.loading)
            .catchError({ (error) -> Observable<PlaylistViewModel> in
                return Observable.just(PlaylistViewModel.error(title: error.localizedDescription, subTitle: nil))
            })
            
        self.observeLoadIntent(loadIntent: loadIntent)
        
        self.observeClickButton(buttonTapped: viewController.clickedButton())

    }
    
    func observeClickButton(buttonTapped: Observable<String?>) {
        buttonTapped.subscribe(onNext: { [weak self] (urlString) in
            guard let urlStr = urlString, let url = URL(string: urlStr) else {
                self?.viewController?.display(viewModel: .error(title:"The url you tapped is not valid", subTitle: nil))
                return
            }
            guard let `self` = self else { return }
            self.viewController?.display(viewModel: .loading)
            self.postURLUC.execute(url).subscribe(onNext: { (item) in
                print("next")
                self.viewController?.display(viewModel: .success)
            }, onError: { (error) in
                print("error")
                self.viewController?.display(viewModel: .error(title:"Url cannot be added to the Playlist", subTitle: error.localizedDescription))
            }, onCompleted: {
                print("completed !")
            }).disposed(by: self.bag)
        }).disposed(by: self.bag)
    }
    
    func observeLoadIntent(loadIntent: Observable<PlaylistViewModel>) {
        loadIntent.subscribe(onNext: { [weak self] (model) in
            self?.viewController?.display(viewModel: model)
        }).disposed(by: bag)
    }
    
    func observeRouting(routeEvent: Observable<PlaylistViewRoute>) {
        routeEvent
        .subscribe(onNext: { [weak self] (route) in
            self?.router.go(to: route) })
        .disposed(by: bag)
    }
    
}
