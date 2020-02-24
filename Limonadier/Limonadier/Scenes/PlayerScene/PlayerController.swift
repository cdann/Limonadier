//
//  PlayerController.swift
//  limonadier
//
//  Created by celine dann on 11/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Domain

protocol PlayerIntents: class {
	func loadIntent() -> Observable<Void>
    func display(viewModel: PlayerModel)
}

class PlayerController: UIViewController {
    
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var progressConstraint: NSLayoutConstraint!
    weak var mainScene: MainScene!
    var presenter: PlayerPresenter!
    var timer: Disposable?
//    var timeChanged: PublishSubject<Int>?
    // var playingTrack: PlaylistItem?
    
    override private init(nibName nibNameOrNil: String? = "PlayerController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(mainScene: MainScene) {
        self.init()
        self.mainScene = mainScene
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Deinit \(self)")
    }

    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach()
    }
    
    func setTime(position: Int, trackDuration: Int) {
        timer?.dispose()
        if position > trackDuration { return }
        timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance).asObservable().subscribe(onNext: { [weak self] (index) in
            let remainingTime = trackDuration - position - index
            if remainingTime > trackDuration || remainingTime < 0 {
                self?.presenter.needToReloadPlayingTrack()
                self?.timer?.dispose()
                return;
            }
            let ratio: CGFloat = CGFloat(remainingTime) / CGFloat(trackDuration)
            self?.progressConstraint = self?.progressConstraint.constraintWithChangedAttribute(multiplier: ratio)
            
        })
    }
    
}

extension PlayerController: PlayerIntents {

	// MARK: - RxIntents
	func loadIntent() -> Observable<Void> {
	 return Observable.just(())
	}

    func display(viewModel: PlayerModel) {
    	switch viewModel {
        case .loading:
            // addLoader()
            break
        case let .display(readingTrack, readingPosition):
            setTime(position: readingPosition, trackDuration: readingTrack.duration)
            // removeLoader()
            break
        case let .error(title: errorTitle, subtitle: subtitle):
            mainScene.alert(errorTitle, subtitle: subtitle)
            // displayError()
            break
        }
    }
}
