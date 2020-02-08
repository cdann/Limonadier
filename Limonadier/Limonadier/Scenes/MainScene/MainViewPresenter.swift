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
    case loading
    case display
    case error(title:String, subTitle: String?)
    case success
}

class  MainViewPresenter {
    private let bag = DisposeBag()
    ///Use the scheduler for debouce, Throttle, etc. The scheduler can be set in the constructor to facilitate tests.
    // private let scheduler: SchedulerType
    
    private let router: MainViewRouterInput
    private weak var viewController: MainViewIntents?
    private var routePublisher = PublishSubject<MainViewRoute>()
    
    private let postURLUC = UseCaseFactory.instance.createUseCase(PostPlaylistUrlUseCase.self)
    private let getPlaylistUC = UseCaseFactory.instance.createUseCase(Domain.GetPlaylistUseCase.self)
    
    let playlist: Observable<Playlist>
    
    init(router: MainViewRouterInput,
         viewController: MainViewIntents) {
        self.router = router
        self.viewController = viewController
        playlist = getPlaylistUC.execute(())
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func loadPlaylist()-> Observable<Playlist> {
        return getPlaylistUC.execute(())
    }
    
    
    
    
    func attach() {
        guard let viewController = viewController else { return }
        self.observeRouting(routeEvent: routePublisher.asObservable())
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
    
    func observeRouting(routeEvent: Observable<MainViewRoute>) {
        routeEvent
        .subscribe(onNext: { [weak self] (route) in
            self?.router.go(to: route) })
        .disposed(by: bag)
    }
    
}
