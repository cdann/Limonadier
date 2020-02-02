//
//  FAButton.swift
//  limonadier
//
//  Created by celine dann on 02/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit
import FontAwesome_swift

@IBDesignable class FAButton: UIButton {
    @IBInspectable var iconName: String? {
        didSet {
            self.titleLabel?.font = UIFont.fontAwesome(ofSize: self.titleLabel?.font.pointSize ?? 20, style: style)
            self.setTitle(String.fontAwesomeIcon(code: iconName ?? ""), for: .normal)
        }
    }
    
    var style : FontAwesomeStyle = .regular {
        didSet {
            self.titleLabel?.font = UIFont.fontAwesome(ofSize: self.titleLabel?.font.pointSize ?? 20, style: style)
        }
    }
    
    var code: FontAwesome? {
        didSet {
            self.titleLabel?.font = UIFont.fontAwesome(ofSize: self.titleLabel?.font.pointSize ?? 20, style: style)
            guard let code = code else { return }
            self.setTitle(String.fontAwesomeIcon(name: code), for: .normal)
        }
    }
}
