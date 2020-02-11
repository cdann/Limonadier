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

protocol PlayerIntents: class {
	func loadIntent() -> Observable<Void>
    func display(viewModel: PlayerModel)
}

class PlayerController: UIViewController {
    
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var progressConstraint: NSLayoutConstraint!
    var presenter: PlayerPresenter!
    
    override init(nibName nibNameOrNil: String? = "PlayerController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
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
}

extension PlayerIntents {

	// MARK: - RxIntents
	func loadIntent() -> Observable<Void> {
	 return Observable.just(())
	}

    func display(viewModel: PlayerModel) {
    	switch viewModel {
        case .loading:
            // addLoader()
            break
        case .display:
            // removeLoader()
            break
        case .error:
            // displayError()
            break
        }
    }
}
