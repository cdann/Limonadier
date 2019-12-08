//
//  ViewController.swift
//  Limonadier
//
//  Created by celine dann on 07/12/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

class ViewController: UIViewController {

    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let useCase = UseCaseFactory.instance.createUseCase(PostPlaylistUrlUseCase.self)
    
        sendButton.rx.tap.bind { [weak self] _ -> () in
            //Domain.PostPlaylistUrlUseCase()
            guard let `self` = self else { return }
            if let urlStr = self.urlField.text, let url = URL(string: urlStr) {
                useCase.execute(url).subscribe(onNext: nil, onError: { (error) in
                    self.alert("url cannot be added to the Playlist", subtitle: error.localizedDescription)
                }, onCompleted: {
                    print("Completed?")
                }, onDisposed: nil).disposed(by: self.disposeBag)
            } else {
                self.alert("the url you tapped is not valid")
            }
        }.disposed(by: disposeBag)
        
    }

    private func alert(_ errorMessage: String, subtitle: String? = nil) {
        let alertCtrl = UIAlertController(title: errorMessage, message: subtitle, preferredStyle: .alert)
        alertCtrl.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
            print("ok")
        }))
        self.present(alertCtrl, animated: false, completion: nil)
    }

}

