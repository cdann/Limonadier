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
import FontAwesome_swift

protocol TrackSenderIntent: class {
    func display(viewModel: TrackSenderModel)
    func clickedButton() -> Observable<String?>
}

class TrackSenderViewController: UIViewController {
    weak var mainScene: MainScene!
    var presenter: TrackSenderPresenter!
    
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var requestStatusIcon: FAIcon!
    
     // MARK: - Init
    override private init(nibName nibNameOrNil: String? = "TrackSenderViewController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(nibName nibNameOrNil: String? = "TrackSenderViewController", bundle nibBundleOrNil: Bundle? = nil, mainScene: MainScene) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.mainScene = mainScene
    }
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach()
    }

}

extension TrackSenderViewController: TrackSenderIntent {
    func clickedButton() -> Observable<String?> {
        return self.sendButton.rx.tap.asObservable()
            .map({ self.urlField.text })
    }
    
    private func changeViewSetup(isButtonHidden: Bool,
                                 iconCode: FontAwesome?,
                                 doAnimateSpinner: Bool) {
        sendButton.isHidden = isButtonHidden
        if let code = iconCode {
            requestStatusIcon.isHidden = false
            requestStatusIcon.code = code
        } else {
            requestStatusIcon.isHidden = true
        }
        if doAnimateSpinner {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    func display(viewModel: TrackSenderModel) {
        let timerToDisplay = { [weak self] in
            guard let `self` = self else { return }
            Observable<Int>.timer(1, scheduler: MainScheduler.instance).subscribe({ _ in
                self.display(viewModel: .display)
            }).disposed(by: self.presenter.bag)
        }
        switch viewModel {
        case .display:
            self.changeViewSetup(isButtonHidden: false,
                                 iconCode: nil,
                                 doAnimateSpinner: false)
        case .loading:
            self.changeViewSetup(isButtonHidden: true,
                             iconCode: nil,
                             doAnimateSpinner: true)
        case .success:
            self.changeViewSetup(isButtonHidden: true,
                             iconCode: .check,
                             doAnimateSpinner: false)
            timerToDisplay()
        case let .error(title: titleError, subTitle: errorMsg):
            self.changeViewSetup(isButtonHidden: true,
                                 iconCode: .times,
                                 doAnimateSpinner: false)
            mainScene.alert(titleError, subtitle: errorMsg)
            timerToDisplay()
        }
    }
    
}
