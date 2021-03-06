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
    func display(viewModel: PlaylistModel)
}

enum PlaylistRow {
    case past(PlaylistItem)
    case reading(PlaylistItem)
    case toRead(PlaylistItem)
}

struct PlaylistSection: SectionModelType {
    typealias Item = PlaylistRow
    
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
    var rowsSubject: PublishSubject<[PlaylistRow]>
    
    // MARK: - Init
    override private init(nibName nibNameOrNil: String? = "PlaylistController", bundle nibBundleOrNil: Bundle? = nil) {
        rowsSubject = PublishSubject()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(nibName nibNameOrNil: String? = "PlaylistController", bundle nibBundleOrNil: Bundle? = nil, mainScene: MainScene) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.mainScene = mainScene
    }
       
    required init?(coder aDecoder: NSCoder) {
        rowsSubject = PublishSubject()
        super.init(coder: aDecoder)
    }

    
    deinit {
        print("Deinit \(self)")
    }
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaylistItemTableViewCell.attach(mTableView)
        mTableView.tableFooterView = UIView()
        rowsSubject.bind(to: mTableView.rx.items) {
            table, index, row in
            let cell = PlaylistItemTableViewCell.dequeueReusableFrom(table)!
            switch row {
            case let .past(item):
                cell.setup(past: item)
            case let .reading(item):
                cell.setup(reading: item)
            case let .toRead(item):
                cell.setup(toRead: item)
            }
            return cell
        }.disposed(by: presenter.bag)
        presenter.attach()
    }
    
}

extension PlaylistController: PlaylistIntent {
    private func changeViewSetup(isTableHidden: Bool, doAnimateSpinner: Bool) {
        mTableView.isHidden = isTableHidden
        if doAnimateSpinner {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
        }
    }
    
    func display(viewModel: PlaylistModel) {
        switch viewModel {
        case .loading:
            changeViewSetup(isTableHidden: true, doAnimateSpinner: true)
            break
        case let .display(rows):
            changeViewSetup(isTableHidden: false, doAnimateSpinner: false)
            rowsSubject.onNext(rows)
            break
        case let .error(title:title, subTitle: subTitle):
            changeViewSetup(isTableHidden: false, doAnimateSpinner: false)
            mainScene.alert(title, subtitle: subTitle)
            break
        }
    }
    
}


