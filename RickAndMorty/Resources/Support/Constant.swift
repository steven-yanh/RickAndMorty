//
//  Constant.swift
//  RickAndMorty
//
//  Created by Huang Yan on 1/30/23.
//

import UIKit

final class K {
    
    static let screenWidth = UIScreen.main.bounds.width
    
    static let screenHeight = UIScreen.main.bounds.height
    
    static var defaultFontSize: CGFloat {
        switch screenHeight {
        case 568: // iPhone SE and 5S
            return 8
        case 667: // iPhone 6 and 7
            return 10
        case 736: // iPhone 6 Plus and 7 Plus
            return 12
        case 812: // iPhone X, XS
            return 14
        case 896: // iPhone XS Max, XR
            return 16
        default:
            return 10
        }
    }
}
