//
//  getSafeViewHeight.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/09/28.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import Foundation
import UIKit

class getSafeViewHeight: NSObject {
    
    func SafeViewHeight(_ deviceHeight: CGFloat) -> CGFloat {
        switch deviceHeight {
        case 812.0://X,Xs
            return 690.0
        case 736.0://plus
            return 672.0
        case 667.0://8.7.6
            return 603.0
        case 568.0://SE
            return 504.0
        case 896.0://XR,XSMAX
            return 774.0
        default:
            return 690.0
        }
    }
}
