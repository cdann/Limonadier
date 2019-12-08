//
//  LandingRouter.swift
//  RxSample
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright (c) 2019 mstv. All rights reserved.
//
//

import Foundation
import UIKit

enum LandingRoute {
    
}

/**
 * The LandingRouterInput protocol declares an interface for LandingRouter
 * Using an interface let you stub the component for Unit Testing
 */
protocol LandingRouterInput {
    static func instantiateController() -> LandingController
    func go(to route: LandingRoute)
}

struct LandingRouter:  LandingRouterInput {
    
    private weak var controller: LandingController?
    
    static func instantiateController() -> LandingController {
        let controller = LandingController(nibName: "LandingController", bundle: nil)
        
        let router = LandingRouter(controller: controller)
        let presenter = LandingPresenter(router: router, viewController: controller)
        controller.presenter = presenter
        
        return controller
    }
    
    func go(to route: LandingRoute) {
//        switch route {
//
//        }
    }
}
