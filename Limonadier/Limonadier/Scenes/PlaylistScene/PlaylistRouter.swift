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
    static func instantiateController() -> PlaylistController
    func go(to route: PlaylistRoute)
}

struct PlaylistRouter:  PlaylistRouterInput {
    
    private weak var controller: PlaylistController?
    
    static func instantiateController() -> PlaylistController {
        let controller = PlaylistController(nibName: "MainViewController", bundle: nil)
        
        let router = PlaylistRouter(controller: controller)
        let presenter = PlaylistViewPresenter(router: router, viewController: controller)
        controller.presenter = presenter
        
        return controller
    }
    
    func go(to route: PlaylistRoute) {
//        switch route {
//
//        }
    }
}
