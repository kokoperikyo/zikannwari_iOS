//
//  umeSothukeizaiViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/09.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit
import PopupDialog

class umeSothukeizaiViewController: UIViewController,UITextFieldDelegate{
    
    @IBAction func unwindActionToUme(segue: UIStoryboardSegue) {
        if segue.identifier == "lecBtnToUme"{
            textFieldBorderEnable(TorF: true)
            //            for i in 0..<txtList.count{
            //
            //            }
        }else if segue.identifier == "barBackBtnToUme"{
            textFieldBorderEnable(TorF: true)
            //            for i in 0..<txtList.count{
            //                txtList[i].isEnabled = true
            //            }
        }
        
    }
    
    @IBOutlet var backViewKeiz: UIView!
    
    
    
    
    var GetLecInfo = NSMutableArray()
    //画面街がタップされた時の判別
    var isTapped:Int = Int()
    
    //選択できる色の一覧
    var col = colorList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //ナビゲーションバーを表示
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        //編集ボタンのセット
        let editButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(umeSothuViewController.clickEditButton))
        //残りの単位数参照ボタンのセット
        let infoButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(umeSothuViewController.clickInfoButton))
        self.navigationItem.setRightBarButtonItems([editButton,infoButton], animated: true)
        
        //表示の比率の設定
        typeRight.constant = backView.bounds.width * 0.8
        lecLeft.constant = backView.bounds.width * 0.2
        backOfTypeViewRight.constant = backView.bounds.width * 0.8
        
        
        
        //textFieldの諸々設定
        textFieldSet()
        //textFieldを編集できないようにする
        textFieldBorderEnable(TorF: false)
        
        //データベースを読んで最新情報を更新
        reloadUme()
        
        
        //左のタイプラベルの大きさ
        for i in 0..<typeOne.count{
            typeOne[i].heightAnchor.constraint(equalTo: typeView.heightAnchor, multiplier: 0.05).isActive = true
        }
        for i in 0..<typeTwo.count{
            typeTwo[i].heightAnchor.constraint(equalTo: typeView.heightAnchor, multiplier: 0.1).isActive = true
        }
        
        typeThree.heightAnchor.constraint(equalTo: typeView.heightAnchor, multiplier: 0.15).isActive = true
        
        typefive.heightAnchor.constraint(equalTo: typeView.heightAnchor, multiplier: 0.25).isActive = true
        
        
        //左のラベルのリストに色をつける
        for i in 0..<labTypeList.count{
            
            //８は６群にあたるのでリストを整えるために排除
            if i == 8{
                continue
            }
            
            var l = db_colorType()
            l = FMDBDatabaseModel.getInstance().GetDataOfColorTyoe(i + 1).object(at: 0) as! db_colorType
            
            switch l.color {
            case 0:
                labTypeList[i].backgroundColor = col.col1
            case 1:
                labTypeList[i].backgroundColor = col.col2
            case 2:
                labTypeList[i].backgroundColor = col.col3
            case 3:
                labTypeList[i].backgroundColor = col.col4
            case 4:
                labTypeList[i].backgroundColor = col.col5
            case 5:
                labTypeList[i].backgroundColor = col.col6
            case 6:
                labTypeList[i].backgroundColor = col.col7
            case 7:
                labTypeList[i].backgroundColor = col.col8
            case 8:
                labTypeList[i].backgroundColor = col.col9
            case 9:
                labTypeList[i].backgroundColor = col.col10
            case 10:
                labTypeList[i].backgroundColor = col.col11
            case 11:
                labTypeList[i].backgroundColor = col.col12
            case 12:
                labTypeList[i].backgroundColor = col.col13
            case 13:
                labTypeList[i].backgroundColor = col.col14
            case 14:
                labTypeList[i].backgroundColor = col.col15
            case 15:
                labTypeList[i].backgroundColor = col.col16
            case 16:
                labTypeList[i].backgroundColor = col.col17
            case 17:
                labTypeList[i].backgroundColor = col.col18
            case 18:
                labTypeList[i].backgroundColor = col.col19
            case 19:
                labTypeList[i].backgroundColor = col.col20
            case 20:
                labTypeList[i].backgroundColor = col.col21
            case 21:
                labTypeList[i].backgroundColor = col.col22
            case 22:
                labTypeList[i].backgroundColor = col.col23
            case 23:
                labTypeList[i].backgroundColor = col.col24
            default:
                labTypeList[i].backgroundColor = UIColor.white
            }
        }
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        isTapped = 0
        
        reloadUme()
    }
    
    
    
    
    //navigationBarの編集ボタンが押された時
    @objc func clickEditButton(){
        
        //保存ボタンのセット
        let saveButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(umeSothuViewController.clickSaveButton))
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
        self.title = "編集中"
        backOfTypeView.alpha = 0.7
        
        textFieldBorderEnable(TorF: true)
        
        for i in 0..<txtList.count{
            
            
            //何も書かれていない場合
            if (txtList[i].text?.isEmpty)!{
                //tagで押されたTFの位置を教える
                txtList[i].tag = i
                txtList[i].addTarget(self, action: #selector(umeSothuViewController.txtTapped(sender:)), for: .editingDidBegin)
                //txtTappedで処理をする
                
                //文字が入っている場合、編集できるようにする
            }else{
                isTapped = 1
            }
        }
        
    }
    
    
    
    //押されたtexiFieldのタイプの講義が一覧になってるページに飛ぶ
    @objc func txtTapped(sender: UITextField){
        
        //たまにclickEditButton()での空欄かどうかの条件分岐をすり抜けてくるのでもう一度条件分岐
        if (txtList[sender.tag].text?.isEmpty)! {
            let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let DV = MainStoryboard.instantiateViewController(withIdentifier: "lecTableFromUmeViewController") as! lecTableFromUmeViewController
            
            DV.getUmeNum = sender.tag
            
            self.navigationController?.pushViewController(DV, animated: true)
        }
        
        
    }
    
    
    //残りの必要単位数が表示されるポップアップビュー
    @objc func clickInfoButton(){
        let vc = PopupViewController(nibName: "PopupViewController", bundle: nil)
        
        // 表示したいビューコントローラーを指定してポップアップを作る
        let popup = PopupDialog(viewController: vc)
        
        // OKボタンを作る
        let buttonOK = DefaultButton(title: "がんばる") {
            
        }
        
        // ポップアップにボタンを追加
        popup.addButton(buttonOK)
        
        // 作成したポップアップを表示する
        present(popup, animated: true, completion: nil)
    }
    
    
    
    //saveボタンが押された時
    //実質画面が開かれた時と同じ初期設定に戻す
    @objc func clickSaveButton(){
        //左のぼやかしを取ってあげる
        backOfTypeView.alpha = 0
        //タイトルを消す
        self.title = ""
        //編集できなくする
        textFieldBorderEnable(TorF: false)
        //再度
        isTapped = 0
        
        //再度読んであげる
        //編集ボタンのセット
        let editButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(umeSothuViewController.clickEditButton))
        let infoButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(umeSothuViewController.clickInfoButton))
        self.navigationItem.setRightBarButtonItems([editButton,infoButton], animated: true)
    }
    
    
    //キーボードを閉じたあとに呼ばれる
    func textFieldDidEndEditing(_ textField:UITextField){
        isTapped = 0
        print(textField.tag)
        print("キーボードを閉じたあと")
        var l = db_umekeiei()
        l = GetLecInfo.object(at: textField.tag) as! db_umekeiei
        //完了ボタンを押した時に文字にの編集が行なわれていた場合
        if l.umeLec != textField.text{
            _ = FMDBDatabaseModel.getInstance().umeUme(lecture: textField.text!, tappedNum: textField.tag + 1)
            
        }
    }
    
    
    
    //完了を押すとkeyboardを閉じる処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Keyboardを閉じる
        textField.resignFirstResponder()
        textFieldBorderEnable(TorF: true)
        
        reloadUme()
        
        txtList[textField.tag].addTarget(self, action: #selector(umeSothuViewController.txtTapped(sender:)), for: .editingDidBegin)
        
        return true
    }
    
    //keyboard以外の画面を押すと、keyboardを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isTapped != 0{
            for i in 0..<txtList.count{
                if (self.txtList[i].isFirstResponder) {
                    self.txtList[i].resignFirstResponder()
                    txtList[i].addTarget(self, action: #selector(umeSothuViewController.txtTapped(sender:)), for: .editingDidBegin)
                }
            }
            textFieldBorderEnable(TorF: true)
            print("keyboard以外の画面")
            //            isTapped = 1
            reloadUme()
            
        }
        
        
        
    }
    
    
    
    //テキストフィールがタップされ、入力可能になったあと
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isTapped = 1
        print("テキストフィールがタップされ、入力可能になったあと")
        //テキストフィールに何か書いてあれば編集可能のまま
        //空欄ならば編集不可にする、そうしないと画面外をタップした時に
        for i in 0..<txtList.count{
            if !(txtList[i].text?.isEmpty)!{
                continue
            }
            txtList[i].isEnabled = false
        }
        
    }
    
    
    
    func reloadUme(){
        GetLecInfo = FMDBDatabaseModel.getInstance().GetLecOfUmeKeiei()
        
        for i in 0..<txtList.count{
            var l = db_umekeiei()
            l = GetLecInfo.object(at: i) as! db_umekeiei
            
            txtList[i].text = l.umeLec
        }
    }
    
    
    //ボーダーラインのスタイル、はっきりしたやつにした
    //textFieldの枠線の色指定、編集不可にすると色が薄くなるので再度指定
    //textFieldの枠の幅、textFieldBorderColorで色指定する時に枠に幅を持たせないと色が反映されない
    func textFieldSet(){
        for i in 0..<txtList.count{
            if i == 11 || i == 17 || i == 20 || i == 23 || i == 26 || i == 29 || i == 44 || i == 58 || i == 59{
                txtList[i].delegate = self
                txtList[i].borderStyle = .line
                txtList[i].layer.borderColor = UIColor.lightGray.cgColor
                txtList[i].layer.borderWidth = 1.0
                txtList[i].layer.backgroundColor = UIColor.lightGray.cgColor
            }else{
                txtList[i].delegate = self
                txtList[i].borderStyle = .line
                txtList[i].layer.borderColor = UIColor.black.cgColor
                txtList[i].layer.borderWidth = 1.0
                //改行ボタンを完了ボタンに変更
                txtList[i].returnKeyType = .done
                txtList[i].tag = i
            }
            
        }
    }
    
    //textFieldを編集不可にする
    func textFieldBorderEnable(TorF:Bool){
        for i in 0..<txtList.count{
            if i == 11 || i == 17 || i == 20 || i == 23 || i == 26 || i == 29 || i == 44 || i == 58 || i == 59{
                txtList[i].isEnabled = false
            }else{
                txtList[i].isEnabled = TorF
            }
            
        }
    }
    
    
}
