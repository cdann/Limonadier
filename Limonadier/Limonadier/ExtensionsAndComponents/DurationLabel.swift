//
//  DurationLabel.swift
//  limonadier
//
//  Created by celine dann on 15/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit

class DurationLabel: UILabel {
    var seconds: Int? {
        didSet {
            guard let seconds = seconds else { return }
            let minutes = seconds / 60
            let remainingSeconds = seconds % 60
            let string = String(format: "%02d:%02d", minutes, remainingSeconds)
            self.text = string
        }
    }
    

}
