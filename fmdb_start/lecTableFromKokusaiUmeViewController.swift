//
//  lecTableFromKokusaiUmeViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/10.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class lecTableFromKokusaiUmeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    //UserDefaultsの宣言
    let userDefault = UserDefaults.standard
    
    //渡ってきた位置(0~53)
    var getUmeNum:Int = Int()
    
    //選考の群
    var selectedSennkou:Int = Int()
    
    @IBOutlet weak var backImgView: UIImageView!
    
    var GetAllLecInfoUme = NSMutableArray()
    
    //埋め卒に埋まっている講義を配列で格納、フィルタ的な役割用
    var GetAllDataOfUme = NSMutableArray()
    //上で取得した配列の講義だけを格納。完全にフィルター用
    //頭に空欄を6個つけることによって上の埋めコマを押しても大丈夫
    var nowUmeLecforAll:[String] = ["","","","","",""]
    var nowUmeLecfor100200:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景画像
        backImgView.image = backgroundList().getBackImg(UserDefaults.standard.integer(forKey: "backImg"))
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        //2or3群
        //今回は3群A専攻にしておく
        selectedSennkou = userDefault.integer(forKey: "selectGunKokusaiNum")
        
        //今埋まっているやつ
        GetAllDataOfUme = FMDBDatabaseModel.getInstanceUmeKeizai().GetLecOfUme()
        for i in 0..<GetAllDataOfUme.count{
            var l = db_umekeizai()
            l = GetAllDataOfUme.object(at: i) as! db_umekeizai
            
            nowUmeLecforAll.append(l.umeLec)
            nowUmeLecfor100200.append(l.umeLec)
        }
        
        //今埋まっているやつ、後ろに29個空欄を作って検索でエラーを出させない
        for _ in 0..<50{
            nowUmeLecforAll.append("")
        }
        
        
        //渡ってきた位置からそのタイプを取得
        let type:Int = typeNum(gettype:getUmeNum)
        
        
        switch type {
        case 200://200は4群と5群から16単位
            GetAllLecInfoUme = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByTypeForUmekokusai(nowUmeLecfor100200)
        case 100://100は3群AorBのどちらかから14単位
            GetAllLecInfoUme = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByTypeForUme200(selectedSennkou, nowUmeLecfor100200)
        case 11://その他自由単位
            GetAllLecInfoUme = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByTypeForUmeZiyuu(nowUmeLecfor100200)
        default://言語〜１群
            GetAllLecInfoUme = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByTypeForUme(type,getUmeNum,nowUmeLecforAll)
        }
        
        
        
        //navigationbarの戻るボタンを隠す
        self.navigationItem.hidesBackButton = true
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetAllLecInfoUme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UmeCellKokusai") as! lecTableFromKokusaiUmeTableViewCell
        

        
        tableView.rowHeight = 60
        //講義ラベルのフォント
        cell.umeLabLec.font = UIFont(name: "Thonburi-Bold", size: 20.0)
        
        
        var l = db_regLec()
        l = GetAllLecInfoUme.object(at: indexPath.row) as! db_regLec
        
        cell.umeLabLec.text = l.regLecture
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var l = db_regLec()
        l = GetAllLecInfoUme.object(at: indexPath.row) as! db_regLec
        
        _ = FMDBDatabaseModel.getInstanceUmeKeizai().umeUme(lecture: l.regLecture, tappedNum: getUmeNum + 1)
    }

    
    
    
    
    
    //渡ってきた位置からタイプを割り出す
    func typeNum(gettype:Int) -> Int {
        if gettype < 6{
            return 1
        }else if gettype < 9{
            return 2
        }else if gettype < 15{
            return 3
        }else if gettype < 21{
            return 4
        }else if gettype < 27{//ここまでは経営経済同じ
            return 5
        }else if gettype < 36{//100は3群AorBのどちらかから14単位
            return 100
        }else if gettype < 45{//200は4群と5群から16単位
            return 200
        }else{
            return 11//その他自由単位
        }
    }

}
