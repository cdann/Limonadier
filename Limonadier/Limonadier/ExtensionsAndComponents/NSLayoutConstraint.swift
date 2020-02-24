//
//  NSLayoutConstraint.swift
//  limonadier
//
//  Created by Céline on 12/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    func constraintWithChangedAttribute(item view1: Any? = nil,
                        attribute attr1: NSLayoutConstraint.Attribute? = nil,
                        relatedBy relation: NSLayoutConstraint.Relation? = nil,
                        toItem view2: Any? = nil,
                        attribute attr2: NSLayoutConstraint.Attribute? = nil,
                        multiplier: CGFloat? = nil,
                        constant c: CGFloat? = nil) -> NSLayoutConstraint {
        let copy = NSLayoutConstraint(item: view1 ?? self.firstItem as Any,
                           attribute: attr1 ?? self.firstAttribute,
                           relatedBy: relation ?? self.relation,
                           toItem: view2 ?? self.secondItem,
                           attribute: attr2 ?? self.secondAttribute,
                           multiplier: multiplier ?? self.multiplier,
                           constant: c ?? self.constant
        )
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([copy])
        return copy
    }
    
}
