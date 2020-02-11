//
//  PlayerRouter.swift
//  limonadier
//
//  Created by celine dann on 11/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import UIKit

enum PlayerRoute {
    
}

/**
 * The LandingRouterInput protocol declares an interface for LandingRouter
 * Using an interface let you stub the component for Unit Testing
 */
protocol LandingRouterInput {
    static func instantiateController() -> PlayerController
    func go(to route: PlayerRoute)
}

final class PlayerRouter: UIView {
    
    private weak var controller: PlayerController?
    
    static func instantiateController() -> PlayerController {
        let controller = PlayerController(nibName: "PlayerController", bundle: nil)
        
        let router = PlayerRouter(controller: controller)
        let presenter = PlayerPresenter(router: router, viewController: controller)
        controller.presenter = presenter
        
        return controller
    }
    
    func go(to route: PlayerRoute) {
//        switch route {
//
//        }
    }
    
}