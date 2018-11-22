//
//  backgroundList.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/22.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import Foundation
import UIKit


class backgroundList: NSObject {
    
    var imgNum = 40
    
    
    //全体の背景画像の設定
    func getBackImg(_ seleNum:Int) -> UIImage {
        
        //assetsにbackImg ＋　数字　で入れてある
        //０からね
        return UIImage(named: "backImg\(seleNum)")!
        
    }
    
    func getListNum() -> Int{
        return imgNum
    }
}
