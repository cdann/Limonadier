//
//  TrackSenderRouter.swift
//  limonadier
//
//  Created by celine dann on 08/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import RxSwift
import Domain

enum TrackSenderRoute {
    
}

/**
 * The MainViewRouterInput protocol declares an interface for MainViewRouter
 * Using an interface let you stub the component for Unit Testing
 */
protocol TrackSenderRouterInput {
    static func instantiateController(mainScene: MainScene, onPlaylistNeedLoading: PublishSubject<Void>) -> TrackSenderViewController
    func go(to route: TrackSenderRoute)
}

struct TrackSenderRouter:  TrackSenderRouterInput {
    
    private weak var controller: TrackSenderViewController?
    
    static func instantiateController(mainScene: MainScene, onPlaylistNeedLoading: PublishSubject<Void>) -> TrackSenderViewController {
        let controller = TrackSenderViewController(mainScene: mainScene)
        
        let router = TrackSenderRouter(controller: controller)
        let presenter = TrackSenderPresenter(router: router, viewController: controller, onPlaylistNeedLoading: onPlaylistNeedLoading)
        controller.presenter = presenter
        
        return controller
    }
    
    func go(to route: TrackSenderRoute) {
//        switch route {
//
//        }
    }
}
