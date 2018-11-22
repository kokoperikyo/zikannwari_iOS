//
//  iPhoneFrame.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/09/05.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import Foundation
import UIKit


class iPhoneFrame: NSObject {
    
    var imgNum = 40
    
    //全体の背景画像の設定
    func getFrameImg(_ seleNum:Int) -> UIImage {
        
        //assetsにbackImg ＋　数字　で入れてある
        //０からね
        if UIScreen.main.nativeBounds.height == 2436{
            return UIImage(named: "iPhoneXFrame\(seleNum)")!
        }else{
            return UIImage(named: "iPhone7Frame\(seleNum)")!
        }
        
        
    }
    
    func getFrameListNum() -> Int{
        return imgNum
    }
}
