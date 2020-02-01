//
//  PlaylistItemCollectionViewCell.swift
//  limonadier
//
//  Created by Céline on 21/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit

class PlaylistItemTableViewCell: UITableViewCell {

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

}
