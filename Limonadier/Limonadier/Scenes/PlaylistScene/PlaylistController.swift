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
import RxDataSources

protocol PlaylistIntent: class {
//    func loadIntent() -> Observable<Playlist>
//    func clickedButton() -> Observable<String?>
//    func observePlaylist(playlist: Observable<Playlist>)
    func display(viewModel: PlaylistModel)
}

protocol PlaylistDelegate: class {
    var playListObs: Observable<Playlist> { get }
}

struct PlaylistSection: SectionModelType {
    typealias Item = [PlaylistItem]
    
    var items: [Item]
    
    init(items: [Item]){
        self.items = items
    }

     init(original: PlaylistSection, items: [Item]) {
        self = original
        self.items = items
    }
}

class PlaylistController: UIViewController {
    
    var presenter: PlaylistPresenter!
    weak var mainScene: MainScene!
    weak var delegate: PlaylistDelegate!
    @IBOutlet weak var mTableView: UITableView!
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
        presenter.attach(playlistObs: delegate.playListObs)
        self.setupTableView(mTableView)
    }
    
}

extension PlaylistController: PlaylistIntent {
    
    
    func display(viewModel: PlaylistModel) {
        switch viewModel {
        case .loading:
            //addLoader()
            break
        case .display:
            //removeLoader()
            self.mTableView.reloadData()
            break
        case let .error(title:title, subTitle: subTitle):
            //removeLoader()
            mainScene.alert(title, subtitle: subTitle)
            break
        }
    }
    
}


extension PlaylistController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView(_ tableView: UITableView) {
        itemCellIdentifier = PlaylistItemTableViewCell.attachAndGetIdentifier(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as! PlaylistItemTableViewCell
    
        // Configure the cell
    
        return cell
    }
}
