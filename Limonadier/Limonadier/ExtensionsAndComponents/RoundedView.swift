//
//  RoundedView.swift
//  limonadier
//
//  Created by Céline on 09/12/2019.
//  Copyright © 2019 celine dann. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = UIScreen.main.bounds.width / 3
    }
}
