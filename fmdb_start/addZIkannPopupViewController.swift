//
//  addZIkannPopupViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/09/07.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class addZIkannPopupViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var labName: UILabel!
    
    
    @IBOutlet weak var txtName: UITextField!
    
    
    static var zikannNameTxt:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.delegate = self
        txtName.clearButtonMode = .whileEditing
        if komaViewController.whichpop == 1{
            txtName.placeholder = "登録する名前を入力してください"
            labName.text = "時間割の新規作成"
        }else{
            txtName.placeholder = "新しい名前を入力してください"
            labName.text = "時間割の名前変更"
        }
        
        txtName.returnKeyType = .done
        
        //からにしておく
        addZIkannPopupViewController.zikannNameTxt = ""
    }

    //完了を押すとkeyboardを閉じる処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Keyboardを閉じる
        textField.resignFirstResponder()
        
        return true
    }

    
    func textFieldShouldEndEditing(_ textField:UITextField) -> Bool {
        
        addZIkannPopupViewController.zikannNameTxt = textField.text!
        print("キーボードを閉じる前")
        return true
    }
}
