//
//  PlaylistViewController.swift
//  Domain
//
//  Created by Céline on 20/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

private let reuseIdentifier = "Cell"

protocol PlaylistIntent: class {
    func loadIntent() -> Observable<Playlist>
//    func clickedButton() -> Observable<String?>
    func display(viewModel: PlaylistViewModel)
}


class PlaylistController: UICollectionViewController {
    
    var presenter: PlaylistPresenter!
    
    override init(nibName nibNameOrNil: String? = "PlaylistController", bundle nibBundleOrNil: Bundle? = nil) {
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
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    
}

extension PlaylistController: PlaylistIntent {
    
    func loadIntent() -> Observable<Playlist> {
        return self.presenter.loadPlaylist()
        // return Observable.timer(3.0, scheduler: MainScheduler.instance).take(3)
    }
    
    func display(model: PlaylistViewModel) {
        switch viewModel {
        case .loading:
            addLoader()
            break
        case .display:
            removeLoader()
            self.collectionView.reloadData()
            break
        case let .error(title:title, subTitle: subTitle):
            removeLoader()
            alert(title, subtitle: subTitle)
            break
        }
    }
    
}
