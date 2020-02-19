//
//  Segment.swift
//  UnderlinedSegmentControl
//
//  Created by Koushik on 19/02/20.
//  Copyright © 2020 Koushik. All rights reserved.
//

import Foundation

class Segment {
    var title: String?
    var subTitle: String?
    
    init(title: String, subTitle: String?=nil) {
        self.title = title
        self.subTitle = subTitle
    }
}
