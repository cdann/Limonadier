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
    case loading
    case display
    case error(title:String, subTitle: String?)
}

class TrackSenderPresenter {
    let bag = DisposeBag()
    private let router: TrackSenderRouterInput
    private weak var viewController: TrackSenderIntent?
    private var routePublisher = PublishSubject<TrackSenderRoute>()
    
    init(router: TrackSenderRouterInput, viewController: TrackSenderIntent) {
        self.router = router
        self.viewController = viewController
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func attach(){
        subscribeViewModel()
    }
    
    func loadingObservable() -> Observable<Int> {
        return Observable.just(2)
    }
    
    func subscribeViewModel() {
        self.viewController?.display(viewModel: .loading)
        let loading = loadingObservable()
        loading.subscribe(onNext: { (_) in
            self.viewController?.display(viewModel: .display)
        }, onError: { (error) in
            self.viewController?.display(viewModel: .error(title: "Playlist cannot be loaded", subTitle: error.localizedDescription))
        }, onCompleted: {
        }).disposed(by: self.bag)
    }
    
}
