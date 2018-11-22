//
//  lecTableFromUmeViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/26.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class lecTableFromUmeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //UserDefaultsの宣言
    let userDefault = UserDefaults.standard

    //渡ってきた位置
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
        
        //今回は４群専攻にしておく
        selectedSennkou = userDefault.integer(forKey: "selectGunKeieiNum")
        
        //今埋まっているやつ
        GetAllDataOfUme = FMDBDatabaseModel.getInstanceUmeKeizai().GetLecOfUme()
        print(GetAllDataOfUme.count)
        
        for i in 0..<GetAllDataOfUme.count{
            var l = db_umekeizai()
            l = GetAllDataOfUme.object(at: i) as! db_umekeizai
            
            nowUmeLecforAll.append(l.umeLec)
            nowUmeLecfor100200.append(l.umeLec)
        }
        
        print(nowUmeLecforAll)
        print(nowUmeLecforAll.count)
        
        //今埋まっているやつ、後ろに空欄を作って検索でエラーを出させない
        //空欄はいっぱい作っておく
        for _ in 0..<50{
            nowUmeLecforAll.append("")
        }
        
        
        //渡ってきた位置からそのタイプを取得
        let type:Int = typeNum(gettype:getUmeNum)
        

        switch type {
        case 100:
            GetAllLecInfoUme = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByTypeForUme100(nowUmeLecfor100200)
        case 200:
            GetAllLecInfoUme = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByTypeForUme200(selectedSennkou, nowUmeLecfor100200)
        case 10:
            GetAllLecInfoUme = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByTypeForUmeZiyuu(nowUmeLecfor100200)
        default:
            GetAllLecInfoUme = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByTypeForUme(type,getUmeNum,nowUmeLecforAll)
        }
        
        
        
        //タイプで検索かけた講義の配列を格納
        //変更
//        GetAllLecInfoUme = FMDBDatabaseModel.getInstance().GetDataOfLecByType(typeNum(gettype:getUmeNum))
        
        
        
        //navigationbarの戻るボタンを隠す
        self.navigationItem.hidesBackButton = true
        
        
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetAllLecInfoUme.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UmeCell") as! lecTableFromUmeTableViewCell
        

        
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
    
//    //tableの埋めるボタンが押された時
//    func umeButton(sender: lecTableFromUmeTableViewCell) {
//        var l = db_regLec()
//        l = GetAllLecInfoUme.object(at: sender.tag) as! db_regLec
//
//        _ = FMDBDatabaseModel.getInstanceUmeKeizai().umeUme(lecture: l.regLecture, tappedNum: getUmeNum + 1)
//    }
    
    

    

   //渡ってきた位置からタイプを割り出す
    func typeNum(gettype:Int) -> Int {
        if gettype < 3{
            return 1
        }else if gettype < 6{
            return 2
        }else if gettype < 12{
            return 3
        }else if gettype < 18{
            return 4
        }else if gettype < 21{
            return 5
        }else if gettype < 24{
            return 6
        }else if gettype < 27{
            return 7
        }else if gettype < 30{
            return 8
        }else if gettype < 36{//100は1~5群から１２単位
            return 100
        }else if gettype < 45{//200は2~5群から一つ選んでってやつ
            return 200
        }else{
            return 10//その他自由単位
        }
    }

}
