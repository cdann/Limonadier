//
//  PlaylistItemCollectionViewCell.swift
//  limonadier
//
//  Created by Céline on 21/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit
import Domain
import FontAwesome_swift

class PlaylistItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heartIcon: FAButton!
    @IBOutlet weak var artistLabel: UILabel!
    
    class func attachAndGetIdentifier(_ tableView: UITableView) -> String {
        let className = String(describing: self)
    
        let nib = UINib(nibName: className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: className)
        return className
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(toRead item: PlaylistItem) {
        commonSetup(item)
        self.heartIcon.isEnabled = true
    }
    
    func setup(past item: PlaylistItem) {
        commonSetup(item)
        self.heartIcon.isEnabled = false
        self.titleLabel.alpha = 0.2
        self.artistLabel.alpha = 0.2
        self.heartIcon.code = FontAwesome.music
        self.heartIcon.style = .solid
        self.heartIcon.alpha = 0.2
    }
    
    func setup(reading item: PlaylistItem) {
        commonSetup(item)
        self.heartIcon.isEnabled = false
        self.backgroundColor = UIColor.titleColor
        self.artistLabel.textColor = UIColor.white
        self.titleLabel.textColor = UIColor.white
        self.heartIcon.code = FontAwesome.play
        self.heartIcon.style = .solid
        self.heartIcon.setTitleColor(UIColor.white, for: .normal)
    }
    
    private func commonSetup(_ item : PlaylistItem) {
        titleLabel.text = item.title
        artistLabel.text = item.artist
        self.selectionStyle = .none
    }

    @IBAction func heartTapped(_ handler: Any) {
        heartIcon.style = heartIcon.style == .regular ? .solid : .regular
    }
    
}
