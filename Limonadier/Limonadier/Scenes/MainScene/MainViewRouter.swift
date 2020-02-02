//
//  MainViewRouter.swift
//  RxSample
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright (c) 2019 mstv. All rights reserved.
//
//

import Foundation
import UIKit
import RxSwift
import Domain

enum MainViewRoute {
    
}

/**
 * The MainViewRouterInput protocol declares an interface for MainViewRouter
 * Using an interface let you stub the component for Unit Testing
 */
protocol MainViewRouterInput {
    static func instantiateController() -> MainViewController
    
    func go(to route: MainViewRoute)
    func addChildrenToController(controller: MainViewController, playlistObs: Observable<Playlist>)
}

struct MainViewRouter:  MainViewRouterInput {
    weak var controller: MainViewController?
    
    
    static func instantiateController() -> MainViewController {
        let controller = MainViewController()
        
        let router = MainViewRouter(controller: controller)
        let presenter = MainViewPresenter(router: router, viewController: controller)
        controller.presenter = presenter
        router.addChildrenToController(controller: controller, playlistObs: presenter.playlist)
        return controller
    }
    
    func go(to route: MainViewRoute) {
//        switch route {
//
//        }
    }
    
    func addChildrenToController(controller: MainViewController, playlistObs: Observable<Playlist>) {
        //Playlist
        let playlist = PlaylistRouter.instantiateController(mainScene: controller, playlistObservable: playlistObs)
        controller.playlistController = playlist
        
        
        // Player
//        let playlist = PlaylistRouter.instantiateController()
//        controller?.playlistController = playlist
        
        //URLField
//        let playlist = PlaylistRouter.instantiateController()
//        controller?.playlistController = playlist
        
    }
}
