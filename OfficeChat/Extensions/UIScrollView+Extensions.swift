//
//  UIScrollView+Extensions.swift
//  OfficeChat
//
//  Created by Paul Nyondo on 15/12/2018.
//  Copyright © 2018 Paul Nyondo. All rights reserved.
//

import Foundation

import UIKit

extension UIScrollView {
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
