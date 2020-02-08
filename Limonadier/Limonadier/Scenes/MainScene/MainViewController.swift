//
//  MainViewController.swift
//  RxSample
//
//  Created by celine dann on 27/11/2019.
//  Copyright (c) 2019 mstv. All rights reserved.
//
//


import Foundation
import UIKit
import RxSwift
import RxCocoa
import Domain

protocol MainScene: class {
    func alert(_ errorMessage: String, subtitle: String?)
}

protocol MainViewIntents: class {
    func display(viewModel: MainViewModel)
}

class MainViewController: UIViewController {

    var presenter: MainViewPresenter!
    @IBOutlet weak var playlistContainer: UIView!
    @IBOutlet weak var trackSenderContainer: UIView!
    
    var playlistController: PlaylistController?
    var trackSenderController: TrackSenderViewController?

    override init(nibName nibNameOrNil: String? = "MainViewController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    

    // MARK: - View LifeCycle
    deinit {
        print("Deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach()
        self.attachChildrenView()
    }
    
    public func attachChildrenView() {
        if let playlistController = playlistController {
            self.addChild(playlistController, in: self.playlistContainer)
        }
        if let trackSenderController = trackSenderController {
            self.addChild(trackSenderController, in: self.trackSenderContainer)
        }
    }
    
    private func addChild(_ childController: UIViewController, in containerView: UIView) {
        self.addChild(childController)
        guard let view = childController.view else { return }
        containerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
    }
}

extension MainViewController: MainScene {
    
    func alert(_ errorMessage: String, subtitle: String? = nil) {
        let alertCtrl = UIAlertController(title: errorMessage, message: subtitle, preferredStyle: .alert)
        alertCtrl.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
            print("ok")
        }))
        self.present(alertCtrl, animated: false, completion: nil)
    }
}

extension MainViewController: MainViewIntents {

    // MARK: - Display
    func display(viewModel: MainViewModel) {
        
    }
    
}
