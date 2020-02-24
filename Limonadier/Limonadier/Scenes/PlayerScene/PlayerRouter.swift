//
//  PlayerRouter.swift
//  limonadier
//
//  Created by celine dann on 11/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import UIKit

enum PlayerRoute {
    
}

/**
 * The LandingRouterInput protocol declares an interface for LandingRouter
 * Using an interface let you stub the component for Unit Testing
 */
protocol PlayerRouterInput {
    static func instantiateController(mainScene: MainScene, playlistChanged: Observable<Playlist>, onPlaylistNeedLoading: PublishSubject<Void>) -> PlayerController
    func go(to route: PlayerRoute)
}

struct PlayerRouter: PlayerRouterInput {
    
    private weak var controller: PlayerController?
    
    static func instantiateController(mainScene: MainScene, playlistChanged: Observable<Playlist>, onPlaylistNeedLoading: PublishSubject<Void>) -> PlayerController {
        let controller = PlayerController(mainScene: mainScene)
        
        let router = PlayerRouter(controller: controller)
        let presenter = PlayerPresenter(router: router, viewController: controller, playlist: playlistChanged, onPlaylistNeedLoading: onPlaylistNeedLoading)
        controller.presenter = presenter
        
        return controller
    }
    
    func go(to route: PlayerRoute) {
//        switch route {
//
//        }
    }
    
}
