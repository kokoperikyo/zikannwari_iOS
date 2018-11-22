//
//  getTiikiNewType.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/10/18.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import Foundation
import UIKit


class getTiikiNewType: NSObject {
    
    let userDefault = UserDefaults.standard
    
    
    
    func getNewType(_ type: Int) -> [Int] {
        let tiikiSennkou = userDefault.integer(forKey: "tiikiSennkou")
        let tiikiGenngo = userDefault.integer(forKey: "tiikiGenngo")
        
        switch type {
//        case 9,10,11:
//            if tiikiSennkou == 1{
//                return []
//            }else if tiikiSennkou == 2{
//                
//            }else if tiikiSennkou == 3{
//                
//            }
//        case 10:
//            <#code#>
//        case 11:
//            <#code#>
//        case 12:
//            <#code#>
//        case 13:
//            <#code#>
//        case 14:
//            <#code#>
//        case 15:
//            <#code#>
//        case 16:
//            <#code#>
//        case 17:
//            <#code#>
//        case 18:
//            <#code#>
//        case 19:
//            <#code#>
//        case 20:
//            <#code#>
        default:
            return [type]
        }
        
        
    }
        
    
    
        

    
}
