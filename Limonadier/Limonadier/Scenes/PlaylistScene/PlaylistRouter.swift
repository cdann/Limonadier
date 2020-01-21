//
//  PlaylistRouter.swift
//  Domain
//
//  Created by Céline on 20/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit

enum PlaylistRoute {
    
}

/**
 * The MainViewRouterInput protocol declares an interface for MainViewRouter
 * Using an interface let you stub the component for Unit Testing
 */
protocol PlaylistRouterInput {
    static func instantiateController(mainScene: MainScene, delegate: PlaylistDelegate) -> PlaylistController
    func go(to route: PlaylistRoute)
}

struct PlaylistRouter:  PlaylistRouterInput {
    
    private weak var controller: PlaylistController?
    
    static func instantiateController(mainScene: MainScene, delegate: PlaylistDelegate) -> PlaylistController {
        let controller = PlaylistController(mainScene: mainScene, delegate: delegate)
        
        let router = PlaylistRouter(controller: controller)
        let presenter = PlaylistPresenter(router: router, viewController: controller)
        controller.presenter = presenter
        
        return controller
    }
    
    func go(to route: PlaylistRoute) {
//        switch route {
//
//        }
    }
}
