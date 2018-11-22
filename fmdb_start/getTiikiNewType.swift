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
    
    
    //選択の基礎科目
    func getKisoSennkou() -> Int {
        let tiikiSennkou = userDefault.integer(forKey: "tiikiSennkou")
        
        switch tiikiSennkou {
        case 1:
            return 9
        case 2:
            return 10
        case 3:
            return 11
        default:
            return 0
        }
    }
    
    //基礎科目のはそのた
    func getKisoSonota() -> [Int] {
        let tiikiSennkou = userDefault.integer(forKey: "tiikiSennkou")
        
        switch tiikiSennkou {
        case 1:
            return [10,11,12]
        case 2:
            return [9,11,12]
        case 3:
            return [9,10,12]
        default:
            return [0]
        }
    }
    
    //選択の発展科目
    func getHattennSennkou() -> Int {
        let tiikiSennkou = userDefault.integer(forKey: "tiikiSennkou")
        
        switch tiikiSennkou {
        case 1:
            return 13
        case 2:
            return 14
        case 3:
            return 15
        default:
            return 0
        }
    }
    
    //発展科目のはそのた
    func getHatennSonota() -> [Int] {
        let tiikiSennkou = userDefault.integer(forKey: "tiikiSennkou")
        
        switch tiikiSennkou {
        case 1:
            return [14,15]
        case 2:
            return [13,15]
        case 3:
            return [13,14]
        default:
            return [0]
        }
    }
    
    
    
    func getTiikiColorNum(_ type: Int) -> Int {
        
        let tiikiSennkou = userDefault.integer(forKey: "tiikiSennkou")
        
        
        switch tiikiSennkou {
        case 1:
            if type == 9{
                return 9
            }else if type == 10 || type == 11 || type == 12{
                return  10
            }else if type == 13{
                return 11
            }else if type == 14 || type == 15{
                return 12
            }
            return 0
            
        case 2:
            if type == 10{
                return 9
            }else if type == 9 || type == 11 || type == 12{
                return  10
            }else if type == 14{
                return 11
            }else if type == 13 || type == 15{
                return 12
            }
            return 0
            
        case 3:
            if type == 11{
                return 9
            }else if type == 9 || type == 10 || type == 12{
                return  10
            }else if type == 15{
                return 11
            }else if type == 13 || type == 14{
                return 12
            }
            return 0
        default:
            return 0
        }
        
        
        
    }
    
    func getTiikiGenColorNum(_ type: Int) -> Int {
        
        let tiikiGenngo = userDefault.integer(forKey: "tiikiGenngo")
        
        switch tiikiGenngo {
        case 1:
            if type == 16{
                return 13
            }else if type == 17{
                return  16
            }
            return 0
        case 2:
            if type == 16{
                return 16
            }else if type == 17{
                return  13
            }
            return 0
        default:
            return 0
        }
        
    }
    
    func getTiikiSitaColorNum(_ type: Int) -> Int {
        
        switch type {
        case 18:
            return 14
        case 19:
            return 15
        case 20:
            return 16
        default:
            return 0
        }
        
    }
    
}
