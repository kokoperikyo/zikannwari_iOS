//
//  allLecViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/21.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class allLecViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UIPickerViewDelegate,UIPickerViewDataSource,allbuttonDelegate{
    
    @IBAction func unwindActionAtAllLecView(segue: UIStoryboardSegue) {
        
    }
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var fromBottomView: UIStackView!
    @IBOutlet weak var kaizyoBtn: UIButton!
    @IBOutlet weak var backImgView: UIImageView!
    
    let userDefault = UserDefaults.standard
    
    
    //下から出てきた
    var tappedKarakara:Int = Int()
    
    //カラカラの検索番号
    var searchType:Int = 0
    
    
    @IBOutlet weak var tblView: UITableView!
    
    let mySections: NSArray = ["月1", "月2","月3", "月4","月5","火1", "火2","火3", "火4","火5","水1", "水2","水3", "水4","水5","木1", "木2","木3", "木4","木5","金1", "金2","金3", "金4","金5"]
    
    let komaNameList: [Int:String] = [0:"月1",1:"月2",2:"月3",3:"月4",4:"月5",5:"火1",6:"火2",7:"火3",8:"火4",9:"火5",10:"水1",11:"水2",12:"水3",13:"水4",14:"水5",15:"木1",16:"木2",17:"木3",18:"木4",19:"木5",20:"金1",21:"金2",22:"金3",23:"金4",24:"金5"]
    
    var searchTypeList:[String] = []

    
    var GetAllDataOfLecInfo = NSMutableArray()
    var GetDataOfLecByLecInfo = NSMutableArray()
    var GetDataOfLecByLecInfoA = NSMutableArray()
    
    
    var lecList:[String] = []
    
    
    //UISearchControllerの宣言
    var searchController = UISearchController(searchResultsController: nil)
    
    //検索結果配列
    var searchResults:[String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //検索バーの検索対象として講義名だけを格納した配列を作る
        GetAllDataOfLecInfo = FMDBDatabaseModel.getInstanceRegLec().GetALLDataOfLec()
        for i in 0..<GetAllDataOfLecInfo.count{
            var l = db_regLec()
            l = GetAllDataOfLecInfo.object(at: i) as! db_regLec
            
            lecList.append(l.regLecture)
            
        }
        
        //学科によってカラカラに表示される選択肢がかわる
        switch userDefault.integer(forKey: "gakkaNum") {
        case 1:
            searchTypeList = ["言語","数理","一般教養","１群","２群","３群","４群","５群","６群","自由単位"]
        case 2:
            searchTypeList = ["言語","数理","一般教養","１群","２群","３群","４群","５群","６群","自由単位"]
        case 3:
            searchTypeList = ["言語","数理","一般教養","１群","２群","３群-A","３群-B","４群","５群","６群","自由単位"]
        case 3:
            searchTypeList = ["言語","数理","一般教養","１群","２群","３群-A","３群-B","４群","５群","６群","自由単位"]
        case 5:
            searchTypeList = ["基幹教養","一般教養（人文）","一般教養（社会）","一般教養（自然）","情報・統計科目群(必修)","情報・統計科目群(選択)","専門導入A","専門導入B","所属専門基礎科目群","専門基礎科目群（その他）","所属専門発展科目群","専門発展科目群（その他）","英語・日本語","専門導入A　（初年次ゼミ）","演　習・卒業論文","自由単位"]
        default:
            print("")
        }
        
        
        //pickerViewのデリゲートの設定
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        //カラカラ一式を下に隠す
        top.constant = backView.bounds.height
        bottom.constant = fromBottomView.bounds.height
        
        
        //カラカラの上につける
        let doneItem = UIBarButtonItem(barButtonSystemItem:.done, target: self, action: #selector(allLecViewController.kannryoTapped))
        toolBar.setItems([doneItem], animated: true)
        
        //上のバーの検索ボタン
        let searchButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(allLecViewController.clickSearchButton))
        
        self.navigationItem.setRightBarButtonItems([searchButton], animated: true)
        

        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //背景画像
        backImgView.image = backgroundList().getBackImg(userDefault.integer(forKey: "backImg"))
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        //navigationbarの戻るボタンを隠す
        self.navigationItem.hidesBackButton = true
        
        
        //結果表示用のビューコントローラーに自分を設定する。
        searchController.searchResultsUpdater = self
        
        //検索中にコンテンツをグレー表示にしない。
        searchController.dimsBackgroundDuringPresentation = false
        
        //テーブルビューのヘッダーにサーチバーを設定する。
        tblView.tableHeaderView = searchController.searchBar
        
        //検索解除ボタンを丸くする
        kaizyoBtn.layer.cornerRadius = 30.0
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if( searchController.searchBar.text != "" ) {
            return 1
        }else if searchType > 0 {
            return 1
        }else {
            return mySections.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if( searchController.searchBar.text != "" ) {
            return ""
        }else if searchType > 0{
            return ""
        }else {
            return mySections[section] as? String
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if( searchController.searchBar.text != "" ) {
            return searchResults.count
        }else if searchType > 0{
            
            //地域の時
            if userDefault.integer(forKey: "gakkaNum") == 5{
                switch searchType {
                case 9:
                    if userDefault.integer(forKey: "tiikiSennkou") == 1{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(9).count
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 2{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(10).count
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 3{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(11).count
                    }
                case 10:
                    if userDefault.integer(forKey: "tiikiSennkou") == 1{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(10, 11,12).count
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 2{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(9, 11,12).count
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 3{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(9, 10,12).count
                    }
                case 11:
                    if userDefault.integer(forKey: "tiikiSennkou") == 1{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(13).count
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 2{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(14).count
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 3{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(15).count
                    }
                case 12:
                    if userDefault.integer(forKey: "tiikiSennkou") == 1{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(13, 14,100).count
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 2{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(13, 15,100).count
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 3{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(13, 14,100).count
                    }
                case 13:
                    if userDefault.integer(forKey: "tiikiGenngo") == 1{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(16).count
                    }else if userDefault.integer(forKey: "tiikiGenngo") == 2{
                        return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(17).count
                    }
                case 14:
                    return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(18).count
                case 15:
                    return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(19).count
                case 16:
                    return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(20).count
                default:
                    return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(searchType).count
                }
                
                
            }else{
                return FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(searchType).count
            }
            
            return 100
            
        }else{
            for i:Int in 0..<mySections.count{
                if section == i{
                    return  FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecAll(i).count
                }
                
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCell") as! allLecTableViewCell

        
        cell.allReg = self
        cell.allShira = self
    
        tableView.rowHeight = 105
        
        //講義ラベルのフォント
        cell.labLec.font = UIFont(name: "Thonburi-Bold", size: 20.0)
        cell.imgRoom.image = UIImage(named: "room1")
        cell.imgTeacher.image = UIImage(named: "teacher1")
        
        
        //上の検索バーに何か文字が入った時（文字が入ると画面がリロードされる）
        if( searchController.searchBar.text != "" ) {
            print("search")

            var l = db_regLec()
            l = GetDataOfLecByLecInfo.object(at: indexPath.row) as! db_regLec
            
    
            
            
            cell.labLec.text = l.regLecture
            cell.labRoom.text = l.regRoom
            cell.labTea.text = l.regTeacher
            cell.tag = l.tappedKoma
            cell.typeNum = l.type
            cell.shiraPage = l.shira
            cell.zennkiOrKoukiNum = l.zennkiOrKouki
            
            //曜日と時限をセットするラベル
            cell.komaName.text = komaNameList[l.tappedKoma]
            
            //前期か後期かセットする
            if l.zennkiOrKouki == 1{
                cell.zennkiOrKouki.text = "前期"
            }else if l.zennkiOrKouki == 2{
                cell.zennkiOrKouki.text = "後期"
            }
            
            


            
        //タイプから検索する下のカラカラの完了ボタンが押されてタイプ検索が実行された時
        } else if searchType > 0{
            var l = db_regLec()
            
            //地域の時
            if userDefault.integer(forKey: "gakkaNum") == 5{
                switch searchType {
                case 9:
                    if userDefault.integer(forKey: "tiikiSennkou") == 1{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(9).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 2{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(10).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 3{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(11).object(at: indexPath.row) as! db_regLec
                    }

                case 10:
                    if userDefault.integer(forKey: "tiikiSennkou") == 1{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(10, 11,12).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 2{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(9, 11,12).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 3{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(9, 10,12).object(at: indexPath.row) as! db_regLec
                    }
                case 11:
                    if userDefault.integer(forKey: "tiikiSennkou") == 1{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(13).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 2{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(14).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 3{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(15).object(at: indexPath.row) as! db_regLec
                    }
                case 12:
                    if userDefault.integer(forKey: "tiikiSennkou") == 1{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(14, 15,100).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 2{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(13, 15,100).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiSennkou") == 3{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfKisoSonotaLecByType(13, 14,100).object(at: indexPath.row) as! db_regLec
                    }
                case 13:
                    if userDefault.integer(forKey: "tiikiGenngo") == 1{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(16).object(at: indexPath.row) as! db_regLec
                    }else if userDefault.integer(forKey: "tiikiGenngo") == 2{
                        l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(17).object(at: indexPath.row) as! db_regLec
                    }
                case 14:
                    l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(18).object(at: indexPath.row) as! db_regLec
                case 15:
                    l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(19).object(at: indexPath.row) as! db_regLec
                case 16:
                    l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(20).object(at: indexPath.row) as! db_regLec
                default:
                    l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(searchType).object(at: indexPath.row) as! db_regLec
                }
                
            }else{
                l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByType(searchType).object(at: indexPath.row) as! db_regLec
            }
            
            

            
            cell.labLec.text = l.regLecture
            cell.labRoom.text = l.regRoom
            cell.labTea.text = l.regTeacher
            cell.tag = l.tappedKoma
            cell.typeNum = l.type
            cell.shiraPage = l.shira
            cell.zennkiOrKoukiNum = l.zennkiOrKouki
            
            //曜日と時限をセットするラベル
            cell.komaName.text = komaNameList[l.tappedKoma]
            
            //前期か後期かセットする
            if l.zennkiOrKouki == 1{
                cell.zennkiOrKouki.text = "前期"
            }else if l.zennkiOrKouki == 2{
                cell.zennkiOrKouki.text = "後期"
            }
            
        //通常の時
        }else {
            for i:Int in 0..<mySections.count{
                if indexPath.section == i{
                    var l = db_regLec()
                    l = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecAll(i).object(at: indexPath.row) as! db_regLec
                    
                    
                    
                    cell.komaName.text = ""
                    cell.zennkiOrKouki.text = ""
                    cell.labLec.text = l.regLecture
                    cell.labRoom.text = l.regRoom
                    cell.labTea.text = l.regTeacher
                    cell.tag = i
                    cell.typeNum = l.type
                    cell.shiraPage = l.shira
                    cell.zennkiOrKoukiNum = l.zennkiOrKouki
                    
                    
                }
            }
        }

        return cell
    }
    
 
    
    //登録ボタンが押された時
    func allRegButton(sender: allLecTableViewCell) {
        
        //前期の時
        if sender.zennkiOrKoukiNum != userDefault.integer(forKey: "zennkiOrKouki"){
            
            let title = "前期の授業は登録できません"
            let message = ""
            let okText = "ok"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okayButton)
            
            present(alert, animated: true, completion: nil)
          
        //後期の時
        }else if sender.zennkiOrKoukiNum == userDefault.integer(forKey: "zennkiOrKouki"){
            
            
            if userDefault.integer(forKey: "gakkaNum") == 5 && sender.typeNum >= 9 && sender.typeNum <= 15{
                sender.typeNum = getTiikiColor().getTiikiColorNum(sender.typeNum)
            }else if userDefault.integer(forKey: "gakkaNum") == 5 && (sender.typeNum == 16 || sender.typeNum == 17){
                sender.typeNum = getTiikiColor().getTiikiGenColorNum(sender.typeNum)
            }else if userDefault.integer(forKey: "gakkaNum") == 5 && sender.typeNum >= 18 && sender.typeNum <= 20{
                sender.typeNum = getTiikiColor().getTiikiSitaColorNum(sender.typeNum)
            }
            
            _ = FMDBDatabaseModel.getInstanceKoma().setKoma(lecture:sender.labLec.text!,room:sender.labRoom.text!, teacher: sender.labTea.text!, type: sender.typeNum,tappedkoma:sender.tag)
            
            
            
            //なんか検索後に登録ボタン押すとたまにNSInvalidArgumentExceptionが出て来てクラッシュする
            //↓こやつを追加して登録ボタンを押すときは検索バーを無効にしたら治った
            self.searchController.isActive = false
            
            //これは重要！！！
            //検索かけた後にtableviewがはみ出る（スクロールが必要な場合は）、リロードしてセルの位置を再認識させてあげないとエラーを吐く
            tblView.reloadData()
            
        }

        
    }
    
    //シラバスボタンが押された時
    func allShiraButton(sender: allLecTableViewCell) {
        
        //前期の時
        if sender.zennkiOrKoukiNum != userDefault.integer(forKey: "zennkiOrKouki"){
            
            let title = "前期のシラバスは見れません"
            let message = ""
            let okText = "ok"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            let okayButton = UIAlertAction(title: okText, style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(okayButton)
            
            present(alert, animated: true, completion: nil)
            
            //後期の時
        }else if sender.zennkiOrKoukiNum == userDefault.integer(forKey: "zennkiOrKouki"){
            
            //        シラバスボタンを押すときは検索バーを無効
            self.searchController.isActive = false
            
            let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let DV = MainStoryboard.instantiateViewController(withIdentifier: "shirabasuFromAllViewController") as! shirabasuFromAllViewController
            
            DV.getPageFromAll = sender.shiraPage
            
            self.navigationController?.pushViewController(DV, animated: true)
            
        }

        
        
    }
    
    //検索バーが押されたり文字が入ると呼ばれる
    func updateSearchResults(for searchController: UISearchController) {

        
        
        //searchResultsには検索に引っかかった講義名のリストが入っている
        searchResults = lecList.filter { data in
                return data.contains(searchController.searchBar.text!)
                
        }
        
        if searchResults.count != 0{
            
            GetDataOfLecByLecInfo = FMDBDatabaseModel.getInstanceRegLec().GetDataOfLecByLec(searchResults)
            
        }
        
        tblView.reloadData()
    
    }
    
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return searchTypeList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return searchTypeList[row]
    }
    
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        
        tappedKarakara = row
        
    }
    
    //上のバーの検索ボタンが押された時の処理
    @objc func clickSearchButton(){
        top.constant = backView.bounds.height * 0.55
        bottom.constant = 0
    
        
        UIView.animate(withDuration: 0.5,
                       animations:{
                        self.view.layoutIfNeeded()
                        
        })
    }
    
    //カラカラの上のバーの完了ボタン
    @objc func kannryoTapped(){
        self.title = searchTypeList[tappedKarakara]
        
        top.constant = backView.bounds.height
        bottom.constant =  fromBottomView.bounds.height
        
        kaizyoBtn.alpha = 1
        
        UIView.animate(withDuration: 0.5,
                       animations:{
                        self.view.layoutIfNeeded()
    
        })
        
        
       searchType = tappedKarakara + 1
        
        
        tblView.reloadData()
    
    }
 
    //解除ボタンが押された時
    @IBAction func kaizyoTapped(_ sender: Any) {
        kaizyoBtn.alpha = 0
        searchType = 0
        tblView.reloadData()

        
    }
    

}

