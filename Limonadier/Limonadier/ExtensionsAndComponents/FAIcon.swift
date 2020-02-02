//
//  FAIcon.swift
//  limonadier
//
//  Created by celine dann on 02/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit
import FontAwesome_swift

@IBDesignable class FAIcon: UILabel {
    @IBInspectable var iconName: String? {
        didSet {
            self.font = UIFont.fontAwesome(ofSize: self.font.pointSize, style: faStyle)
            self.text = String.fontAwesomeIcon(code: iconName ?? "")
        }
    }
    
    
    @IBInspectable var style: String? {
        didSet {
            if let style = style, let faStyle = FontAwesomeStyle(rawValue: style) {
                self.faStyle = faStyle
            }
        }
    }
    
    var faStyle : FontAwesomeStyle = .regular {
        didSet {
            self.font = UIFont.fontAwesome(ofSize: self.font.pointSize ?? 20, style: faStyle)
        }
    }
    
    var code: FontAwesome? {
        didSet {
            self.font = UIFont.fontAwesome(ofSize: self.font.pointSize, style: faStyle)
            guard let code = code else { return }
            self.text = String.fontAwesomeIcon(name: code)
        }
    }
}

