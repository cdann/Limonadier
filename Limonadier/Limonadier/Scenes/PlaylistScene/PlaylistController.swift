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
    typealias Item = PlaylistItem
    
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
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var mTableView: UITableView!
    
    var presenter: PlaylistPresenter!
    weak var mainScene: MainScene!
    weak var delegate: PlaylistDelegate!
    var itemCellIdentifier = ""
    
    let bag = DisposeBag()
    
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
        itemCellIdentifier = PlaylistItemTableViewCell.attachAndGetIdentifier(mTableView)
        
        mTableView.tableFooterView = UIView()
        
        self.presenter.loadPlaylist().map { $0.items }
        .bind(to: mTableView.rx.items) { table, index, element in
            let cell = table.dequeueReusableCell(withIdentifier: self.itemCellIdentifier) as! PlaylistItemTableViewCell
            cell.setupCell(element)
            return cell
        }
        .disposed(by: bag)
    }
    
}

extension PlaylistController: PlaylistIntent {
    
    
    func display(viewModel: PlaylistModel) {
        switch viewModel {
        case .loading:
            mTableView.isHidden = true
            spinner.startAnimating()
            break
        case .display:
            mTableView.isHidden = false
            spinner.stopAnimating()
            break
        case let .error(title:title, subTitle: subTitle):
            mTableView.isHidden = false
            spinner.stopAnimating()
            mainScene.alert(title, subtitle: subTitle)
            break
        }
    }
    
}


