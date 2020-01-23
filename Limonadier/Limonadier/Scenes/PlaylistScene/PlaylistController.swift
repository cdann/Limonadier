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


protocol PlaylistIntent: class {
//    func loadIntent() -> Observable<Playlist>
//    func clickedButton() -> Observable<String?>
//    func observePlaylist(playlist: Observable<Playlist>)
    func display(viewModel: PlaylistModel)
}

protocol PlaylistDelegate: class {
    var playListObs: Observable<Playlist> { get }
}


class PlaylistController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: PlaylistPresenter!
    weak var mainScene: MainScene!
    weak var delegate: PlaylistDelegate!
    @IBOutlet weak var collectionView: UICollectionView!
    var itemCellIdentifier = ""
    
    override private init(nibName nibNameOrNil: String? = "PlaylistController", bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(nibName nibNameOrNil: String? = "PlaylistController", bundle nibBundleOrNil: Bundle? = nil, mainScene: MainScene, delegate: PlaylistDelegate) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.mainScene = mainScene
        self.delegate = delegate
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
        itemCellIdentifier  = PlaylistItemCollectionViewCell.attachAndGetIdentifier(self.collectionView)
        presenter.attach(playlistObs: delegate.playListObs)
    }
    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! PlaylistItemCollectionViewCell
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    
}

extension PlaylistController: PlaylistIntent {
    
    
    func display(viewModel: PlaylistModel) {
        switch viewModel {
        case .loading:
            //addLoader()
            break
        case .display:
            //removeLoader()
            self.collectionView.reloadData()
            break
        case let .error(title:title, subTitle: subTitle):
            //removeLoader()
            mainScene.alert(title, subtitle: subTitle)
            break
        }
    }
    
}
