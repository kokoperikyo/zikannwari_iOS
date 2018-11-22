//
//  getWhichDevice.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/09/27.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import Foundation
import UIKit


class getWhichDevice: NSObject {
    
    func getDeviceNum(_ deviceHeight: CGFloat) -> Int {
        switch deviceHeight {
        case 812.0://X,Xs
            return 1
        case 736.0://plus
            return 2
        case 667.0://8.7.6
            return 3
        case 568.0://SE
            return 4
        case 896.0://XR,XSMAX
            return 5
        default:
            return 10
        }
    }
}
