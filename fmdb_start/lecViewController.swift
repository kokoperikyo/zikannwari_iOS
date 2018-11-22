//
//  lecViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/16.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit
import PopupDialog

class lecViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,buttonDelegate {
    
    @IBAction func unwindActionAtLecView(segue: UIStoryboardSegue) {
        
    }

    @IBOutlet weak var tbl: UITableView!
    
    @IBOutlet weak var backImgView: UIImageView!
    

    
    var getNum:Int = Int()
    var GetDataInfoLec = NSMutableArray()
    
    let userDefault = UserDefaults.standard
    
    //タイトルに表示するやつ
    var youbi:String = String()
    var zigenn:String = String()
    
    //アイコン
    var imgRoom1 = UIImage(named:"room2")!
    var imgTeacher1 = UIImage(named:"teacher1")!
    var imgshira = UIImage(named:"shira1")!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        GetDataInfoLec = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLec(getNum)
        
        
        
        youbi = getYoubi(getNum)
        zigenn = getZigenn(getNum)
        
        self.title = youbi+zigenn
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        //背景画像のセット
        backImgView.image = backgroundList().getBackImg(UserDefaults.standard.integer(forKey: "backImg"))

        
        //講義の追加ポップアップビューを出すボタン
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(lecViewController.clickAddButton))
        self.navigationItem.setRightBarButtonItems([addButton], animated: true)
        
        
    }



    
    //シラバス参照ボタン
    func shiraButton(sender: TableViewCell) {
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "shiraImgViewController") as! shiraImgViewController
        
        DV.getPage = sender.shiraPage
        
        self.navigationController?.pushViewController(DV, animated: true)
    }
    
    
    
    
    //講義の追加ボタンが押された時の処理
    @objc func clickAddButton(){
        
        // ポップアップに表示したいビューコントローラー
        let vc = addPopupViewController(nibName: "addPopupViewController", bundle: nil)
        
        
        // 表示したいビューコントローラーを指定してポップアップを作る
        let popup = PopupDialog(viewController: vc)
        
        // OKボタンを作る
        let buttonOK = DefaultButton(title: "追加") {
            
            _ = FMDBDatabaseModel.getInstanceKoma().setKoma(lecture:addPopupViewController.lecText,room:addPopupViewController.roomText, teacher: "", type: self.getNum + 17,tappedkoma:self.getNum)
            
            let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let DV = MainStoryboard.instantiateViewController(withIdentifier: "komaViewController") as! komaViewController
        
            self.navigationController?.pushViewController(DV, animated: false)
        }
        
        // ポップアップにボタンを追加
        popup.addButton(buttonOK)
        
        // 作成したポップアップを表示する
        present(popup, animated: true, completion: nil)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.GetDataInfoLec.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblCell") as! TableViewCell

        cell.shira = self
        
        
        tableView.rowHeight = 110
        //講義ラベルのフォント
        cell.labLec.font = UIFont(name: "Thonburi-Bold", size: 25.0)
        //講義名が長過ぎて見切れたらフォントサイズを小さくする
        cell.labLec.adjustsFontSizeToFitWidth = true
        cell.labRoom.adjustsFontSizeToFitWidth = true
        cell.labTeacher.adjustsFontSizeToFitWidth = true
        cell.labShira.adjustsFontSizeToFitWidth = true
        
        
        var l = db_regLec()
        l = GetDataInfoLec.object(at: indexPath.row) as! db_regLec
        
        cell.labLec.text = l.regLecture
        cell.labRoom.text = l.regRoom
        cell.labTeacher.text = l.regTeacher
        cell.tag = l.type
        cell.shiraPage = l.shira
        cell.imgRoom.image = imgRoom1
        cell.imgTeacher.image = imgTeacher1
        cell.imgShira.image = imgshira
        
        return cell
    }
    
    
    //セルが押された時、登録
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var l = db_regLec()
        l = GetDataInfoLec.object(at: indexPath.row) as! db_regLec
        
        if userDefault.integer(forKey: "gakkaNum") == 5 && l.type >= 9 && l.type <= 15{
            l.type = getTiikiColor().getTiikiColorNum(l.type)
        }else if userDefault.integer(forKey: "gakkaNum") == 5 && (l.type == 16 || l.type == 17){
            l.type = getTiikiColor().getTiikiGenColorNum(l.type)
        }else if userDefault.integer(forKey: "gakkaNum") == 5 && l.type >= 18 && l.type <= 20{
            l.type = getTiikiColor().getTiikiSitaColorNum(l.type)
        }
        
        _ = FMDBDatabaseModel.getInstanceKoma().setKoma(lecture:l.regLecture,room:l.regRoom, teacher: l.regTeacher, type: l.type,tappedkoma:getNum)
    }
    
    
    
    func getYoubi(_ getKoma:Int) -> String {
        if getKoma < 5{
            return "月"
        }else if getKoma < 10{
            return "火"
        }else if getKoma < 15{
            return "水"
        }else if getKoma < 20{
            return "木"
        }else if getKoma < 25{
            return "金"
        }
        return ""
    }
    
    func getZigenn(_ getKoma:Int) -> String {
        if getKoma % 5 == 0{
            return "1限"
        }else if getKoma % 5 == 1{
            return "2限"
        }else if getKoma % 5 == 2{
            return "3限"
        }else if getKoma % 5 == 3{
            return "4限"
        }else if getKoma % 5 == 4{
            return "5限"
        }
        return ""
    }
    

}
