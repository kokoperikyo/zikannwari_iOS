//
//  getKeyboardHeight.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/09/28.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import Foundation
import UIKit

class getKeyboardHeight: NSObject {
    
    func getKeyHeight(_ deviceHeight: CGFloat) -> CGFloat {
        switch deviceHeight {
        case 812.0://X
            return 333.0
        case 736.0://plus
            return 271.0
        case 667.0://8.7.6
            return 258.0
        case 568.0://SE
            return 253.0
        case 896.0://XR、XsMAX
            return 301.0
        default:
            return 333.0
        }
    }
}
