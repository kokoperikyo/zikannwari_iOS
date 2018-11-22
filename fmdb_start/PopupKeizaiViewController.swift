//
//  PopupKeizaiViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/10.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class PopupKeizaiViewController: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var stackTate: UIStackView!
    @IBOutlet var stackYoko: [UIStackView]!
    
    @IBOutlet var labList: [UILabel]!
    

    var GetAllUmeInfo = NSMutableArray()
    var lecList:[String] = []
    
    var gennNum:Int = Int()
    var suuriNum:Int = Int()
    var ippanNum:Int = Int()
    var oneNum:Int = Int()
    var TwoOrThreeNum:Int = Int()
    var oneToFiveNum:Int = Int()
    var ziyuuNum:Int = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetAllUmeInfo = FMDBDatabaseModel.getInstanceUmeKeizai().GetLecOfUme()
        for i in 0..<GetAllUmeInfo.count{
            var l = db_umekeizai()
            l = GetAllUmeInfo.object(at: i) as! db_umekeizai
            lecList.append(l.umeLec)
        }
        
        stackTate.spacing = 1
        
        for i in 0..<stackYoko.count{
            stackYoko[i].spacing = 1
        }
        
        for i in 0..<labList.count{
            labList[i].backgroundColor = UIColor.white
        }
        
        
        //各タイプの空欄の個数を数える
        for i in 0..<lecList.count{
            if i < 3{
                if !((lecList[i].isEmpty)){
                    gennNum += 1
                }
            }else if i < 6{
                if !((lecList[i].isEmpty)){
                    suuriNum += 1
                }
            }else if i < 12{
                if !((lecList[i].isEmpty)){
                    ippanNum += 1
                }
            }else if i < 18{
                if !((lecList[i].isEmpty)){
                    oneNum += 1
                }
            }else if i < 24{
                if !((lecList[i].isEmpty)){
                    TwoOrThreeNum += 1
                }
            }else if i < 39{
                if !((lecList[i].isEmpty)){
                    oneToFiveNum += 1
                }
            }else if i < 54{
                if !((lecList[i].isEmpty)){
                    ziyuuNum += 1
                }
            }
        }
        
        
        //ポップアップビューの必要単位の表示を設定
        labList[1].text = "  " + String((3 - gennNum) * 2) + "単位"
        labList[3].text = "  " + String((3 - suuriNum) * 2) + "単位"
        labList[5].text = "  " + String((5 - ippanNum) * 2) + "単位"
        labList[7].text = "  " + String((6 - oneNum) * 2) + "単位"
        labList[9].text = "  " + String((6 - TwoOrThreeNum) * 2) + "単位"
        labList[11].text = "  " + String((15 - oneToFiveNum) * 2) + "単位"
        labList[13].text = "  " + String((13 - ziyuuNum) * 2) + "単位"
        
        //残り必要単位数が０単位の時に表示を変える
        for i in 1..<labList.count / 2 + 1{
            if labList[(i * 2) - 1].text == "  0単位"{
                labList[(i * 2) - 1].text = "  埋まった"
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
