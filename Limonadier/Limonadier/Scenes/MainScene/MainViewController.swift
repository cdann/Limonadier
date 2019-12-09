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

protocol MainViewIntents: class {
	func loadIntent() -> Observable<Void>
    func clickedButton() -> Observable<String?>
    func display(viewModel: MainViewModel)
}

class MainViewController: UIViewController {

    var presenter: MainViewPresenter!
    var spinner: UIView? = nil
    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var sendButton: UIButton!

     override init(nibName nibNameOrNil: String? = "MainViewController", bundle nibBundleOrNil: Bundle? = nil) {
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
    
    func addLoader() {
        guard let view = self.view else { return }
        if spinner == nil {
            let indicator = UIActivityIndicatorView(frame: view.bounds)
            indicator.startAnimating()
            spinner = indicator
        }
        urlField.isHidden = true
        sendButton.isEnabled = false
        self.view.addSubview(spinner!)
    }
    
    func removeLoader() {
        spinner?.removeFromSuperview()
        urlField.isHidden = false
        sendButton.isEnabled = true
    }
    
    private func alert(_ errorMessage: String, subtitle: String? = nil) {
        let alertCtrl = UIAlertController(title: errorMessage, message: subtitle, preferredStyle: .alert)
        alertCtrl.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
            print("ok")
        }))
        self.present(alertCtrl, animated: false, completion: nil)
    }
    
}

extension MainViewController: MainViewIntents {
    func clickedButton() -> Observable<String?> {
        return self.sendButton.rx.tap.asObservable().map({ self.urlField.text })
    }
    
    // MARK: - RxIntents
    func loadIntent() -> Observable<Void> {
        //return Observable.just(())
        return self.presenter.loadThings().map({ _ in () })
    }

    // MARK: - Display
    func display(viewModel: MainViewModel) {
        switch viewModel {
        case .loading:
            addLoader()
            break
        case .display:
            removeLoader()
            break
        case let .error(title:title, subTitle: subTitle):
            removeLoader()
            alert(title, subtitle: subTitle)
            break
        case .success:
            removeLoader()
            alert("Success")
        }
    }
}
