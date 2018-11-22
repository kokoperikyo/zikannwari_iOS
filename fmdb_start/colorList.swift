//
//  colorList.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/06.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import Foundation
import UIKit

class colorList: NSObject {

    let col1:UIColor = #colorLiteral(red: 1, green: 0.966563046, blue: 0, alpha: 1)
    let col2:UIColor = #colorLiteral(red: 1, green: 0.9994774461, blue: 0.3987594843, alpha: 1)
    let col3:UIColor = #colorLiteral(red: 0.9232409, green: 0.9966198802, blue: 0.6536642909, alpha: 1)
    let col4:UIColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
    let col5:UIColor = #colorLiteral(red: 0.3977446258, green: 1, blue: 0, alpha: 1)
    let col6:UIColor = #colorLiteral(red: 0.727298677, green: 1, blue: 0.4514689445, alpha: 1)
    let col7:UIColor = #colorLiteral(red: 0, green: 1, blue: 0.4534871578, alpha: 1)
    let col8:UIColor = #colorLiteral(red: 0, green: 1, blue: 0.746078968, alpha: 1)
    let col9:UIColor = #colorLiteral(red: 0.5493359566, green: 0.9966570735, blue: 0.9922243953, alpha: 1)
    let col10:UIColor = #colorLiteral(red: 0.0278343223, green: 0.3323037624, blue: 1, alpha: 1)
    let col11:UIColor = #colorLiteral(red: 0, green: 0.7243170142, blue: 1, alpha: 1)
    let col12:UIColor = #colorLiteral(red: 0, green: 0.9920454621, blue: 0.9959782958, alpha: 1)
    let col13:UIColor = #colorLiteral(red: 0.4698347449, green: 0.3606033623, blue: 1, alpha: 1)
    let col14:UIColor = #colorLiteral(red: 0.6820620894, green: 0.567303896, blue: 1, alpha: 1)
    let col15:UIColor = #colorLiteral(red: 0.9057230353, green: 0.600643456, blue: 1, alpha: 1)
    let col16:UIColor = #colorLiteral(red: 0.7106890082, green: 0.1087090448, blue: 1, alpha: 1)
    let col17:UIColor = #colorLiteral(red: 0.9079090357, green: 0, blue: 1, alpha: 1)
    let col18:UIColor = #colorLiteral(red: 1, green: 0.3352409005, blue: 0.9980435967, alpha: 1)
    let col19:UIColor = #colorLiteral(red: 1, green: 0.08094616979, blue: 0.4363470376, alpha: 1)
    let col20:UIColor = #colorLiteral(red: 1, green: 0.3523406386, blue: 0.5298855901, alpha: 1)
    let col21:UIColor = #colorLiteral(red: 0.9924576879, green: 0.4450648427, blue: 0.498180449, alpha: 1)
    let col22:UIColor = #colorLiteral(red: 1, green: 0.08787140995, blue: 0.3104794025, alpha: 1)
    let col23:UIColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
    let col24:UIColor = #colorLiteral(red: 1, green: 0.552949369, blue: 0.2675289512, alpha: 1)
    
    func targetColor(_ data: Int) -> UIColor {
        switch data {
        case 0:
            return col1
        case 1:
            return col2
        case 2:
            return col3
        case 3:
            return col4
        case 4:
            return col5
        case 5:
            return col6
        case 6:
            return col7
        case 7:
            return col8
        case 8:
            return col9
        case 9:
            return col10
        case 10:
            return col11
        case 11:
            return col12
        case 12:
            return col13
        case 13:
            return col14
        case 14:
            return col15
        case 15:
            return col16
        case 16:
            return col17
        case 17:
            return col18
        case 18:
            return col19
        case 19:
            return col20
        case 20:
            return col21
        case 21:
            return col22
        case 22:
            return col23
        case 23:
            return col24
        case 99:
            return UIColor.white
        default:
            return UIColor.white
        }
    }
}

