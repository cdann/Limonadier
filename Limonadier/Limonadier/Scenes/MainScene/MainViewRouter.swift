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
    func addChildrenToController(controller: MainViewController, playlistDidChange:PublishSubject<Playlist>, onPlaylistNeedLoading: PublishSubject<Void>)
}

struct MainViewRouter:  MainViewRouterInput {
    weak var controller: MainViewController?
    
    
    static func instantiateController() -> MainViewController {
        let controller = MainViewController()
        
        let router = MainViewRouter(controller: controller)
        let presenter = MainViewPresenter(router: router, viewController: controller)
        controller.presenter = presenter
        router.addChildrenToController(controller: controller, playlistDidChange: presenter.playlistChanged, onPlaylistNeedLoading: presenter.needToLoadPlaylist)
        return controller
    }
    
    func go(to route: MainViewRoute) {
//        switch route {
//
//        }
    }
    
    func addChildrenToController(controller: MainViewController, playlistDidChange:PublishSubject<Playlist>, onPlaylistNeedLoading: PublishSubject<Void>) {
        //Playlist
        let playlist = PlaylistRouter.instantiateController(mainScene: controller, playlist: playlistDidChange)
        controller.playlistController = playlist
        
        
        // Player
        #warning("see mainscene")
        let player = PlayerRouter.instantiateController(mainScene: controller, playlistChanged: playlistDidChange, onPlaylistNeedLoading: onPlaylistNeedLoading)
        controller.playerController = player
//        let playlist = PlaylistRouter.instantiateController()
//        controller?.playlistController = playlist
        
        //URLField
        let trackSender = TrackSenderRouter.instantiateController(mainScene: controller, onPlaylistNeedLoading: onPlaylistNeedLoading)
        controller.trackSenderController = trackSender
//        let playlist = PlaylistRouter.instantiateController()
//        controller?.playlistController = playlist
        
    }
}
