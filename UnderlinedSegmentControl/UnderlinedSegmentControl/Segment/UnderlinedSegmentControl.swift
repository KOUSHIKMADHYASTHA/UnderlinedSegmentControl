//
//  DesignableSegment.swift
//  OwnSegment
//
//  Created by Koushik on 18/02/20.
//  Copyright © 2020 Koushik. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UnderlinedSegmentControl: UIView {
    private var segments: [Segment]!
    
    @IBInspectable
    var activeSegmentColor: UIColor = .white
    
    @IBInspectable
    var segmentColor: UIColor = .white
    
    @IBInspectable
    var textColor: UIColor = .black
    
    @IBInspectable
    var activeTextColor: UIColor = .white
    
    var titleFont: UIFont = .systemFont(ofSize: 18.0, weight: .medium)
    
    var subTitleFont: UIFont = .systemFont(ofSize: 18.0, weight: .medium)
    
    var currentIndex: Int?
    
    func setTitles(segments: [Segment], currentIndex: Int, fonts: [UIFont]) {
        self.segments = segments
        self.currentIndex = currentIndex
        if let first = fonts.first {
            self.titleFont = first
        }
        if let last = fonts.last {
            self.subTitleFont = last
        }
        self.updateView()
    }
    var mainStack: UIStackView!
    var delegate: UnderlinedSegmentControlDelegate!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    func updateView() {
        if mainStack == nil {
            var arrangedViews = [UIStackView]()
            var tap: UITapGestureRecognizer!
            if let segments = segments {
                for (index, segment) in segments.enumerated() {
                    let titleLabel = createLabel()
                    titleLabel.text = segment.title
                    titleLabel.textColor = (index == currentIndex) ? activeTextColor : textColor
                    var subTitleLabel: UILabel!
                    if let subTitle = segment.subTitle {
                        subTitleLabel = createLabel()
                        subTitleLabel.text = subTitle
                        subTitleLabel.textColor = (index == currentIndex) ? activeTextColor : textColor
                    }
                    let underlineView = UIView()
                    underlineView.translatesAutoresizingMaskIntoConstraints = false
                    underlineView.heightAnchor.constraint(equalToConstant: 4).isActive = true
                    underlineView.backgroundColor = activeTextColor
                    underlineView.alpha = (index == currentIndex) ? 1 : 0
                    underlineView.tag = 4
                    var stack: UIStackView!
                    if let subTitleLabel = subTitleLabel {
                        stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
                    }else {
                        stack = UIStackView(arrangedSubviews: [titleLabel])
                    }
                    stack.axis = .vertical
                    stack.spacing = 2
                    stack.alignment = .fill
                    stack.distribution = .fillProportionally
                    stack.tag = 5
                    let containerStack = UIStackView(arrangedSubviews: [stack, underlineView])
                    containerStack.axis = .vertical
                    containerStack.tag = index
                    tap = UITapGestureRecognizer(target: self, action: #selector(UnderlinedSegmentControl.didTapSegment(sender:)))
                    containerStack.addGestureRecognizer(tap)
                    containerStack.addBackground(color: (currentIndex == index) ? activeSegmentColor : segmentColor)
                    arrangedViews.append(containerStack)
                }
            }
            mainStack = UIStackView(arrangedSubviews: arrangedViews)
            mainStack.backgroundColor = activeSegmentColor
            mainStack.axis = .horizontal
            mainStack.alignment = .fill
            mainStack.distribution = .fillEqually
            self.addSubview(mainStack)
            mainStack.translatesAutoresizingMaskIntoConstraints = false
            mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            mainStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            mainStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
    }
    @objc func didTapSegment(sender:UITapGestureRecognizer) {
        for subviews in mainStack.arrangedSubviews {
            if subviews == sender.view {
                if let delegate = delegate {
                    delegate.didTapSegementWith(index: subviews.tag)
                }
            }
            UIView.animate(withDuration: 0.3) {[weak self] in
                if let arrangedView = subviews as? UIStackView {
                    arrangedView.addBackground(color: ((subviews == sender.view) ? self?.activeSegmentColor : self?.segmentColor)!)
                    for subview in arrangedView.arrangedSubviews {
                        if subview.tag == 4{
                            subview.alpha = (subviews == sender.view) ? 1 : 0
                        }
                        if subview.tag == 5 {
                            if let stack = subview as? UIStackView {
                                for title in stack.arrangedSubviews {
                                    if let label = title as? UILabel {
                                        label.textColor = (subviews == sender.view) ? self?.activeTextColor : self?.textColor
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func createLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = titleFont
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }
}
protocol UnderlinedSegmentControlDelegate: class {
    func didTapSegementWith(index: Int)
}
