//
//  PlaylistItemCollectionViewCell.swift
//  limonadier
//
//  Created by Céline on 21/01/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit

class PlaylistItemCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func attachAndGetIdentifier(_ collectionView: UICollectionView) -> String {
        let className = "PlaylistItemCollectionViewCell"
        let nib = UINib(nibName: className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: className)
        return className
    }

}
