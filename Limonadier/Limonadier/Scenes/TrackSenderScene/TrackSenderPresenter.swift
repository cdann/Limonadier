//
//  TrackSenderPresenter.swift
//  limonadier
//
//  Created by celine dann on 08/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import RxSwift
import Domain

enum TrackSenderModel {
    case loading //while sending
    case display //waiting for an input
    case success //input sent
    case error(title:String, subTitle: String?) // input error
}

class TrackSenderPresenter {
    let bag = DisposeBag()
    private let router: TrackSenderRouterInput
    private weak var viewController: TrackSenderIntent?
    private var routePublisher = PublishSubject<TrackSenderRoute>()
    private var onPlaylistNeedLoading: PublishSubject<Void>
    
    private let postURLUC = UseCaseFactory.instance.createUseCase(PostPlaylistUrlUseCase.self)
    
    init(router: TrackSenderRouterInput, viewController: TrackSenderIntent, onPlaylistNeedLoading: PublishSubject<Void>) {
        self.router = router
        self.viewController = viewController
        self.onPlaylistNeedLoading = onPlaylistNeedLoading
    }
    
    
    deinit {
        print("Deinit \(self)")
    }
    
    func attach(){
        guard let viewController = viewController else { return }
        self.observeRouting(routeEvent: routePublisher.asObservable())
        self.observeClickButton(buttonTapped: viewController.clickedButton())
    }
    
    func observeClickButton(buttonTapped: Observable<String?>) {
        self.viewController?.display(viewModel: .display)
        buttonTapped.subscribe(onNext: { [weak self] (urlString) in
            guard let urlStr = urlString, let url = URL(string: urlStr) else {
                self?.viewController?.display(viewModel: .error(title:"The url you tapped is not valid", subTitle: nil))
                return
            }
            guard let `self` = self else { return }
            self.viewController?.display(viewModel: .loading)
            self.postURLUC.execute(url).subscribe(onNext: { (item) in
                self.viewController?.display(viewModel: .success)
                self.onPlaylistNeedLoading.on(.next(()))
            }, onError: { (error) in
                self.viewController?.display(viewModel: .error(title:"The url cannot be added to the Playlist", subTitle: error.localizedDescription))
            }, onCompleted: {
            }).disposed(by: self.bag)
        }).disposed(by: self.bag)
    }
    
    func observeRouting(routeEvent: Observable<TrackSenderRoute>) {
        routeEvent
        .subscribe(onNext: { [weak self] (route) in
            self?.router.go(to: route) })
        .disposed(by: bag)
    }
}
