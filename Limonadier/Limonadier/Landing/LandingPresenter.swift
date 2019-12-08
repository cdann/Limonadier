//
//  LandingPresenter.swift
//  RxSample
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright (c) 2019 mstv. All rights reserved.
//
//

import Foundation
import RxSwift

enum LandingModel {
    case loading
    case display
    case error(Error)
}

class  LandingPresenter {
    private let bag = DisposeBag()
    ///Use the scheduler for debouce, Throttle, etc. The scheduler can be set in the constructor to facilitate tests.
   // private let scheduler: SchedulerType
    
    private let router: LandingRouterInput
    private weak var viewController: LandingIntents?
    private var routePublisher = PublishSubject<LandingRoute>()
    
    init(router: LandingRouterInput,
         viewController: LandingIntents) {
        self.router = router
        self.viewController = viewController
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func attach() {
        guard let viewController = viewController else { return }
        
        
        let loadIntent = viewController.loadIntent()
            .map { LandingModel.display }
            .startWith(.loading)
            .catchError({ (error) -> Observable<LandingModel> in
                return Observable.just(LandingModel.error(error))
            })
            
        Observable.merge([loadIntent]).subscribe(onNext: { [weak self] (model) in
            self?.viewController?.display(viewModel: model)
        }).disposed(by: bag)
        
        routePublisher
            .subscribe(onNext: { [weak self] (route) in
                self?.router.go(to: route) })
            .disposed(by: bag)
        
        //viewController.closeErrorIntent()
        //   .map {LandingRoute.error}
        //   .bind(to: routePublisher)
        //   .disposed(by: bag)
    }
    
}
