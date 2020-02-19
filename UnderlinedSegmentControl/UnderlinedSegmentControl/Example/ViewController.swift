//
//  ViewController.swift
//  UnderlinedSegmentControl
//
//  Created by Koushik on 19/02/20.
//  Copyright © 2020 Koushik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var segment: UnderlinedSegmentControl! {
        didSet {
            segment.setTitles(segments: [Segment(title: "First"), Segment(title: "Second", subTitle: "2"), Segment(title: "Third", subTitle: "3")], currentIndex: 1, fonts: [])
            // MARK : Set custom fonts for title and subtitle here
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        segment.delegate = self
        changeContainerColor(index: segment.currentIndex!)
    }
    func changeContainerColor(index: Int) {
        switch index {
        case 0:
            container.backgroundColor = UIColor.red
            break
        case 1:
            container.backgroundColor = UIColor.green
            break
        case 2:
            container.backgroundColor = UIColor.blue
            break
        default:
            container.backgroundColor = UIColor.white
        }
        
    }
}

extension ViewController: UnderlinedSegmentControlDelegate {
    func didTapSegementWith(index: Int) {
        changeContainerColor(index: index)
        // MARK : Perform action based on index
    }
}
