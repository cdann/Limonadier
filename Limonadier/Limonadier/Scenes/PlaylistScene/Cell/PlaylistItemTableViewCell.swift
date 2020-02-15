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
    @IBOutlet weak var durationLabel: DurationLabel!
    class var className: String {
        return String(describing: self)
    }
    
    class func attach(_ tableView: UITableView){
        let nib = UINib(nibName: className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: className)
    }
    
    class func dequeueReusableFrom(_ tableView: UITableView) -> PlaylistItemTableViewCell? {
        return tableView.dequeueReusableCell(withIdentifier: self.className) as? PlaylistItemTableViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupText(color: UIColor, alpha: CGFloat) {
        self.artistLabel.textColor = color
        self.titleLabel.textColor = color
        self.heartIcon.setTitleColor(color, for: .normal)
        self.titleLabel.alpha = alpha
        self.artistLabel.alpha = alpha
        self.heartIcon.alpha = alpha
    }
    
    private func commonSetup(_ item : PlaylistItem) {
        titleLabel.text = item.title
        artistLabel.text = item.artist
        durationLabel.seconds = item.duration
        self.selectionStyle = .none
    }
    
    func changeSetupParameters(iconEnabled: Bool,
                              iconCode: FontAwesome,
                              iconStyle: FontAwesomeStyle,
                              textColor: UIColor,
                              textAlpha: CGFloat,
                              backgroundColor: UIColor) {
        self.heartIcon.isEnabled = iconEnabled
        self.heartIcon.code = iconCode
        self.heartIcon.style = iconStyle
        setupText(color: textColor, alpha: textAlpha)
        self.backgroundColor = backgroundColor
    }
    
    func setup(toRead item: PlaylistItem) {
        commonSetup(item)
        changeSetupParameters(iconEnabled: true,
                              iconCode: .heart,
                              iconStyle: .regular,
                              textColor: .titleColor,
                              textAlpha: 1,
                              backgroundColor: .white)
    }
    
    func setup(past item: PlaylistItem) {
        commonSetup(item)
        changeSetupParameters(iconEnabled: false,
                              iconCode: .music,
                              iconStyle: .solid,
                              textColor: .titleColor,
                              textAlpha: 0.2,
                              backgroundColor: .white)
    }
    
    func setup(reading item: PlaylistItem) {
        commonSetup(item)
        changeSetupParameters(iconEnabled: false,
                              iconCode: .play,
                              iconStyle: .solid,
                              textColor: .white,
                              textAlpha: 1,
                              backgroundColor: .titleColor)
    }
    
    
    
    

    @IBAction func heartTapped(_ handler: Any) {
        heartIcon.style = heartIcon.style == .regular ? .solid : .regular
    }
    
}
