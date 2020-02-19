//
//  UIStackView+Utils.swift
//  UnderlinedSegmentControl
//
//  Created by Koushik on 19/02/20.
//  Copyright © 2020 Koushik. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        if let view = self.viewWithTag(100) {
            UIView.animate(withDuration: 0.3, animations: {
                view.alpha = 0.0
            }) { (isCompleted) in
                view.removeFromSuperview()
            }
        }
        let subView = UIView(frame: bounds)
        subView.tag = 100
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
