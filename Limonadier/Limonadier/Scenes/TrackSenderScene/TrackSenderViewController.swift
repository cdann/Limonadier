//
//  TrackSenderViewController.swift
//  limonadier
//
//  Created by celine dann on 08/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import RxDataSources

protocol TrackSenderIntent: class {
    func display(viewModel: TrackSenderModel)
}

class TrackSenderViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var presenter: TrackSenderPresenter!
    weak var mainScene: MainScene!
    
    // MARK: - Init
    override private init(nibName nibNameOrNil: String? = "PlaylistController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(nibName nibNameOrNil: String? = "PlaylistController", bundle nibBundleOrNil: Bundle? = nil, mainScene: MainScene) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.mainScene = mainScene
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

extension TrackSenderViewController: TrackSenderIntent {
    
    
    func display(viewModel: TrackSenderModel) {
        switch viewModel {
        case .loading:
            spinner.startAnimating()
            break
        case .display:
            spinner.stopAnimating()
            break
        case let .error(title:title, subTitle: subTitle):
            spinner.stopAnimating()
            mainScene.alert(title, subtitle: subTitle)
            break
        }
    }
    
}
