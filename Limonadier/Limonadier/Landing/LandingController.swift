//
//  LandingController.swift
//  RxSample
//
//  Created by Célian MOUTAFIS on 27/11/2019.
//  Copyright (c) 2019 mstv. All rights reserved.
//
//


import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol LandingIntents: class {
	func loadIntent() -> Observable<Void>
    func display(viewModel: LandingModel)
}

class LandingController: ViewController {

    var presenter: LandingPresenter!

     override init(nibName nibNameOrNil: String? = "LandingController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View LifeCycle
    deinit {
        print("Deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach()

    }
}

extension LandingController: LandingIntents {
    
    // MARK: - RxIntents
    func loadIntent() -> Observable<Void> {
        return Observable.just(())
    }

    // MARK: - Display
    func display(viewModel: LandingModel) {
        switch viewModel {
        case .loading:
            addLoader()
            break
        case .display:
            removeLoader()
            break
        case .error:
            removeLoader()
            break
        }
    }
}
