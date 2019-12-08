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
    
    init(router: MainViewRouterInput,
         viewController: MainViewIntents) {
        self.router = router
        self.viewController = viewController
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func attach() {
        guard let viewController = viewController else { return }
        
        
        let loadIntent = viewController.loadIntent()
            .map { MainViewModel.display }
            .startWith(.loading)
            .catchError({ (error) -> Observable<MainViewModel> in
                return Observable.just(MainViewModel.error(title: error.localizedDescription, subTitle: nil))
            })
            
        Observable.merge([loadIntent]).subscribe(onNext: { [weak self] (model) in
            self?.viewController?.display(viewModel: model)
        }).disposed(by: bag)
        
        routePublisher
            .subscribe(onNext: { [weak self] (route) in
                self?.router.go(to: route) })
            .disposed(by: bag)
        
        viewController.clickedButton().subscribe(onNext: { [weak self] (urlString) in
            guard let urlStr = urlString, let url = URL(string: urlStr) else {
                self?.viewController?.display(viewModel: .error(title:"The url you tapped is not valid", subTitle: nil))
                return
            }
            guard let `self` = self else { return }
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
        //viewController.closeErrorIntent()
        //   .map {MainViewRoute.error}
        //   .bind(to: routePublisher)
        //   .disposed(by: bag)
    }
    
}
