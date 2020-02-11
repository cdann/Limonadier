//
//  PlayerPresenter.swift
//  limonadier
//
//  Created by celine dann on 11/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import UIKit

enum PlayerModel {
    case loading
    case display
    case error(Error)
}

final class PlayerPresenter: UIView {

    private let bag = DisposeBag()

    init(router: PlayerRouterInput,
         viewController: PlayerIntents) {
        self.router = router
        self.viewController = viewController
    }
    
    deinit {
        print("Deinit \(self)")
    }
    
    func attach() {
        guard let viewController = viewController else { return }
        
        
        let loadIntent = viewController.loadIntent()
            .map { PlayerModel.display }
            .startWith(.loading)
            .catchError({ (error) -> Observable<PlayerModel> in
                return Observable.just(PlayerModel.error(error))
            })
            
        Observable.merge([loadIntent]).subscribe(onNext: { [weak self] (model) in
            self?.viewController?.display(viewModel: model)
        }).disposed(by: bag)
        
        routePublisher
            .subscribe(onNext: { [weak self] (route) in
                self?.router.go(to: route) })
            .disposed(by: bag)
        
        //viewController.closeErrorIntent()
        //   .map {PlayerRoute.error}
        //   .bind(to: routePublisher)
        //   .disposed(by: bag)
    }
    
}
