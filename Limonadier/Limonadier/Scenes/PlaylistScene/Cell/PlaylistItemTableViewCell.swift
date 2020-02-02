//
//  PlaylistItemCollectionViewCell.swift
//  limonadier
//
//  Created by Céline on 21/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit
import Domain

class PlaylistItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heartIcon: FAButton!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func attachAndGetIdentifier(_ tableView: UITableView) -> String {
        let className = String(describing: self)
    
        let nib = UINib(nibName: className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: className)
        return className
    }
    
    func setupCell(_ item: PlaylistItem) {
        titleLabel.text = item.title
        artistLabel.text = item.artist
    }

    @IBAction func heartTapped(_ handler: Any) {
        heartIcon.style = heartIcon.style == .regular ? .solid : .regular
    }
}
