//
//  PopupKokusaiViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/10.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class PopupKokusaiViewController: UIViewController {
    
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
    var twoNum:Int = Int()
    var AorB:Int = Int()
    var fourAndFive:Int = Int()
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
            if i < 6{
                if !((lecList[i].isEmpty)){
                    gennNum += 1
                }
            }else if i < 9{
                if !((lecList[i].isEmpty)){
                    suuriNum += 1
                }
            }else if i < 15{
                if !((lecList[i].isEmpty)){
                    ippanNum += 1
                }
            }else if i < 21{
                if !((lecList[i].isEmpty)){
                    oneNum += 1
                }
            }else if i < 24{
                if !((lecList[i].isEmpty)){
                    twoNum += 1
                }
            }else if i < 36{
                if !((lecList[i].isEmpty)){
                    AorB += 1
                }
            }else if i < 45{
                if !((lecList[i].isEmpty)){
                    fourAndFive += 1
                }
            }else if i < 60{
                if !((lecList[i].isEmpty)){
                    ziyuuNum += 1
                }
            }
        }
        
        
        //ポップアップビューの必要単位の表示を設定
        labList[1].text = "  " + String((5 - gennNum) * 2) + "単位"
        labList[3].text = "  " + String((3 - suuriNum) * 2) + "単位"
        labList[5].text = "  " + String((5 - ippanNum) * 2) + "単位"
        labList[7].text = "  " + String((5 - oneNum) * 2) + "単位"
        labList[9].text = "  " + String((5 - twoNum) * 2) + "単位"
        labList[11].text = "  " + String((7 - AorB) * 2) + "単位"
        labList[13].text = "  " + String((8 - fourAndFive) * 2) + "単位"
        labList[15].text = "  " + String((13 - ziyuuNum) * 2) + "単位"
        
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
