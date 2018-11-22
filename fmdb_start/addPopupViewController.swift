//
//  addPopupViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/03.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit


class addPopupViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var txtLec: UITextField!
    @IBOutlet weak var txtRoom: UITextField!

    
    static var lecText:String = String()
    static var roomText:String = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        txtLec.delegate = self
        txtRoom.delegate = self
        
        txtLec.clearButtonMode = .whileEditing
        txtRoom.clearButtonMode = .whileEditing
        
        txtLec.placeholder = "追加する講義名を入力してください"
        txtRoom.placeholder = "追加する教室を入力してください"
        
        txtLec.returnKeyType = .done
        txtRoom.returnKeyType = .done
        
        //からにしておく
        addPopupViewController.lecText = ""
        addPopupViewController.roomText = ""
        
    }


    
    //完了を押すとkeyboardを閉じる処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //Keyboardを閉じる
        textField.resignFirstResponder()

        return true
    }
    
    
    
    
    func textFieldShouldEndEditing(_ textField:UITextField) -> Bool {
        
        if textField.tag == 1{
            addPopupViewController.lecText = textField.text!
        }else{
            addPopupViewController.roomText = textField.text!
        }
        print("キーボードを閉じる前")
        return true
    }
    
    
    
    


    


}
