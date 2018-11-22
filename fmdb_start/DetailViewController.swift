//
//  DetailViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/17.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController ,UITextFieldDelegate,UITextViewDelegate{
    
    @IBAction func unwindActionAtDetailView(segue: UIStoryboardSegue) {
        
    }
    
    let userDefault = UserDefaults.standard
    
    var getLec:String = String()
    var getRoom:String = String()
    var getteacher:String = String()
    var getCom:String = String()
    var getKomaNum:Int = Int()
    var getType:Int = Int()
    var getSyussekiCount:Int = Int()
    var getTikokuCount:Int = Int()
    var getKessekiCount:Int = Int()
    
    
    var placeholderLabel : UILabel!
    
    @IBOutlet weak var memoView: UIView!
    @IBOutlet weak var txtVCom: UITextView!
    
    
    @IBOutlet weak var syussekiView: UIView!
    @IBOutlet weak var syussekiTop: NSLayoutConstraint!
    @IBOutlet weak var syousaiImg: UIImageView!
    @IBOutlet weak var minusView1: UIView!
    @IBOutlet weak var minusView2: UIView!
    @IBOutlet weak var minusView3: UIView!
    @IBOutlet weak var plusView1: UIView!
    @IBOutlet weak var plusView2: UIView!
    @IBOutlet weak var plusView3: UIView!
    
    
    @IBOutlet weak var syussekiCountLab: UILabel!
    @IBOutlet weak var tikokuCountLab: UILabel!
    @IBOutlet weak var kessekiCountLab: UILabel!
    
    
    
    
    
    
    //背景画像
    @IBOutlet weak var backImgView: UIImageView!
    //全部入れてるVIew
    @IBOutlet weak var contentVIew: UIView!
    @IBOutlet weak var contentTop: NSLayoutConstraint!
    @IBOutlet weak var contentBottom: NSLayoutConstraint!
    
    
    //上半分の基本情報を入れているView
    @IBOutlet weak var kihonnInfoView: UIView!
    //間隔
    var kihonnViewSpacing = CGFloat()
    //上半分の基本情報を入れているViewの各要素を入れている各Viewのリスト
    @IBOutlet var kihonnInfoList: [UIView]!
    @IBOutlet var TTShiColList: [UIView]!
    

    @IBOutlet weak var txtLec: UITextField!
    @IBOutlet weak var txtRoom: UITextField!
    @IBOutlet weak var labTeacher: UILabel!
    @IBOutlet weak var labType: UILabel!
    @IBOutlet weak var btnShira: UIButton!
    @IBOutlet weak var labShira: UILabel!
    @IBOutlet weak var btnColor: UIButton!
    @IBOutlet weak var labColor: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorColorView: UIView!
    @IBOutlet weak var rejumeView: UIView!
    @IBOutlet weak var labCamera: UILabel!
    @IBOutlet weak var labKibutu: UILabel!
    
    
    
    @IBOutlet weak var setLecIconView: UIView!
    //アイコン画像
    @IBOutlet weak var lecImgView: UIImageView!
    @IBOutlet weak var roomImgView: UIImageView!
    @IBOutlet weak var teaImgVIew: UIImageView!
    @IBOutlet weak var typeImgView: UIImageView!
    @IBOutlet weak var shiraImgView: UIImageView!
    @IBOutlet weak var colorImgView: UIImageView!
    @IBOutlet weak var cameraImgView: UIImageView!
    @IBOutlet weak var kibutuImgView: UIImageView!
    
    
    
    
    @IBOutlet weak var sizeImgLec: NSLayoutConstraint!
    @IBOutlet weak var sizeImgRoom: NSLayoutConstraint!
    @IBOutlet weak var sizeImgTea: NSLayoutConstraint!
    @IBOutlet weak var sizeImgType: NSLayoutConstraint!
    @IBOutlet weak var sizeImgShira: NSLayoutConstraint!
    
    @IBOutlet weak var sizeImgColor: NSLayoutConstraint!
    
    @IBOutlet weak var sizeViewColor: NSLayoutConstraint!
    
    @IBOutlet weak var sizeImgCamera: NSLayoutConstraint!
    
    @IBOutlet weak var sizeImgKibutu: NSLayoutConstraint!
    
    
    var corner = CGFloat()
    var screenHeight = CGFloat()
    var kyboardHeight = CGFloat()
    var safeViewHeight = CGFloat()
    var itemBarHeight = CGFloat()
    var delOrSave = Int()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtLec.delegate = self
        txtRoom.delegate = self
        txtVCom.delegate = self
        
        txtLec.borderStyle = .none
        txtRoom.borderStyle = .none
        
        
        txtLec.text = getLec
        txtRoom.text = getRoom
        labTeacher.text = getteacher
        txtVCom.text = getCom
        
        labShira.adjustsFontSizeToFitWidth = true
        labColor.adjustsFontSizeToFitWidth = true
        labCamera.adjustsFontSizeToFitWidth = true
        labKibutu.adjustsFontSizeToFitWidth = true
        
        syousaiImg.image = UIImage(named: "info2")
        
        
        screenHeight = view.bounds.height
        
        //出欠管理の管理
        print(getSyussekiCount)
        userDefault.set(getSyussekiCount,forKey:"syussekiCount")
        userDefault.set(getTikokuCount,forKey:"tikokuCount")
        userDefault.set(getKessekiCount,forKey:"kessekiCount")
        
        syussekiCountLab.text = userDefault.string(forKey:"syussekiCount")
        tikokuCountLab.text = userDefault.string(forKey:"tikokuCount")
        kessekiCountLab.text = userDefault.string(forKey:"kessekiCount")
        
        
        //丸みをゲット
        getCorner()
        
        //上半分のViewの設定ろいろ
        setKihonnView()
        
        //上半分のViewのアイコン画像のセット
        setIconImg()
        
        //タイプをセットする
        setTypeLab()
        
        //色設定の横の色セット
        setColor()
        
        //テキストフィールドの設定もろもろ
        setTxtF()
        
        //メモのところの設定もろもろ
        setTxtV()
        
        //出欠のボタン
        setSyukketuPulaMin()
        

        //一番下の出席とレジュメのViewのレイアウト、４０ってのは各スペースの合計
        syussekiTop.constant = (getSafeViewHeight().SafeViewHeight(screenHeight) - 50.0) * 0.25 * 0.3
        
        //navigationBarの処理
        //deleteボタンの追加
        let deleteButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: self, action: #selector(DetailViewController.clickDeleteButton))

        self.navigationItem.setRightBarButtonItems([deleteButton], animated: true)
        
    
        //背景画像
        backImgView.image = backgroundList().getBackImg(UserDefaults.standard.integer(forKey: "backImg"))
        
        // ナビゲーションを透明にする処理
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    func getCorner(){
        let deviceHeightNum = getWhichDevice().getDeviceNum(view.bounds.height)
        
        
        switch deviceHeightNum {
        case 1:
            corner = 62.0
        case 2:
            corner = 60.33
        case 3:
            corner = 53.5
        case 4:
            corner = 43.5
        case 5:
            corner = 70.33//70.5
        default:
            true
        }
    }
    

    func setKihonnView(){
        
        let space:CGFloat = 5.0

        //基本Viewの各要素を丸くする
        for i in 0..<kihonnInfoList.count{
            kihonnInfoList[i].layer.cornerRadius = corner * 0.5
        }
        
        //基本Viewの先生、タイプ、シラバス、いろを丸くする
        for i in 0..<TTShiColList.count{
            TTShiColList[i].layer.cornerRadius = corner * 0.5
        }
        
        sizeViewColor.constant = corner + space
        colorView.layer.cornerRadius = corner * 0.5
        colorView.layer.borderWidth = 2.0
        colorView.layer.borderColor = #colorLiteral(red: 0.529668808, green: 0.5257498622, blue: 0.5326701999, alpha: 1)
        colorColorView.layer.cornerRadius = corner * 0.5 - 8.0
    }
    
    
    
    func setIconImg(){
        lecImgView.image = UIImage(named: "lec2")!
        roomImgView.image = UIImage(named: "room2")!
        teaImgVIew.image = UIImage(named: "teacher1")!
        typeImgView.image = UIImage(named: "type1")!
        shiraImgView.image = UIImage(named: "shira1")!
        colorImgView.image = UIImage(named: "color1")!
        cameraImgView.image = UIImage(named: "camera1")!
        kibutuImgView.image = UIImage(named: "kibutu1")!

        //ここでアイコンを入れているViewを高さ合わせの正方形にする、その中にアイコンを入れている
        sizeImgLec.constant = corner
        sizeImgRoom.constant = corner
        sizeImgTea.constant = corner
        sizeImgType.constant = corner
        sizeImgShira.constant = corner
        sizeImgColor.constant = corner
        sizeImgCamera.constant = corner
        sizeImgKibutu.constant = corner
        
        
    }
    
    func setTypeLab(){
        let gakkaNumber = userDefault.integer(forKey: "gakkaNum")
        
        switch getType {
        case 1:
            labType.text = "言語"
        case 2:
            labType.text = "数理"
        case 3:
            labType.text = "一般教養"
        case 4:
            if gakkaNumber == 1 || gakkaNumber == 2 || gakkaNumber == 3{
                labType.text = "1群"
            }else if gakkaNumber == 4{
                labType.text = "経営学科"
            }
        case 5:
            if gakkaNumber == 1 || gakkaNumber == 2 || gakkaNumber == 3{
                labType.text = "2群"
            }else if gakkaNumber == 4{
                labType.text = "経済学科"
            }
        case 6:
            if gakkaNumber == 1 || gakkaNumber == 2{
                labType.text = "3群"
            }else if gakkaNumber == 3{
                labType.text = "3群A"
            }else if gakkaNumber == 4{
                labType.text = "国際学科"
            }
        case 7:
            if gakkaNumber == 1 || gakkaNumber == 2{
                labType.text = "4群"
            }else if gakkaNumber == 3{
                labType.text = "3群B"
            }
        case 8:
            if gakkaNumber == 1 || gakkaNumber == 2{
                labType.text = "5群"
            }else if gakkaNumber == 3{
                labType.text = "4群"
            }
        case 9:
            if gakkaNumber == 1 || gakkaNumber == 2{
                labType.text = "6"
            }else if gakkaNumber == 3{
                labType.text = "5群"
            }
        case 10:
            if gakkaNumber == 1 || gakkaNumber == 2 || gakkaNumber == 4{
                labType.text = "自由単位"
            }else if gakkaNumber == 3{
                labType.text = "6群"
            }
        case 11:
            if gakkaNumber == 1 || gakkaNumber == 2{
                labType.text = ""
            }else if gakkaNumber == 3{
                labType.text = "自由単位"
            }
        default:
            true
        }
    }
    
    
    func setColor(){
        
        let GetDataInfoKomaColor = FMDBDatabaseModel.getInstanceColorType().GetDataOfColorTyoe(getType)

        var l = db_colorType()
        l = GetDataInfoKomaColor.object(at: 0) as! db_colorType
        
        
        colorColorView.backgroundColor = colorList().targetColor(l.color)
    }
    
    func setTxtF(){
        
        //入力している文字を全消しするclearボタンを設定(書いている時のみの設定)
        txtLec.clearButtonMode = .whileEditing
        txtRoom.clearButtonMode = .whileEditing
        
        //文字が何も入力されていない時に表示される文字(薄っすら見える文字)
        txtLec.placeholder = "講義名を入力してください"
        txtRoom.placeholder = "教室を入力してください"
        
        //改行ボタンを完了ボタンに変更
        txtLec.returnKeyType = .done
        txtRoom.returnKeyType = .done
    }
    
    
    func setTxtV(){
        //txtVComの処理
        //宣言
        placeholderLabel = UILabel()
        //うっすらと表示させる文字
        placeholderLabel.text = "メモ的なやつ"
        //正直ブラックボックス
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (txtVCom.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        
        //うっすら文字のうっすら具合を決める
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtVCom.font?.pointSize)! / 2)
        //うっすら文字の色
        placeholderLabel.textColor = UIColor.lightGray

        //textViewにうっすらと表示させる文字を認識させる？的な
        txtVCom.addSubview(placeholderLabel)
        
        
        
        
//        //枠の表示と太さの設定
//        txtVCom.layer.borderWidth = 1
//        // 角に丸みをつける.
//        txtVCom.layer.masksToBounds = true
//        // 丸みのサイズを設定する
//        txtVCom.layer.cornerRadius = 5.0
//        //枠の色変更
//        txtVCom.layer.borderColor = UIColor.black.cgColor
        
        //キードードを閉じるボタンを作るためにツールバーを生成
        let toolBar = UIToolbar()
        
        //toolBarのサイズを設定
        toolBar.frame = CGRect(x: 0, y: 0, width: 300, height: 30)
        
        //画面幅に合わせるように設定
        toolBar.sizeToFit()
        
        itemBarHeight = toolBar.bounds.height
        
        //Doneボタンを右に配置するためのスペース
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        //Doneボタン
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(DetailViewController.doneButton))
        
        //ツールバーにボタンを設定
        toolBar.items = [space,doneButton]
        
        //textViewにツールバーを設定
        txtVCom.inputAccessoryView = toolBar
        
        //Viewに追加
        self.memoView.addSubview(txtVCom)
        
        placeholderLabel.isHidden = !txtVCom.text.isEmpty
        
        memoView.layer.cornerRadius = 10
    }
    
    //出欠のボタン
    func setSyukketuPulaMin(){
        let minusImg:UIImage = UIImage(named:"minus1")!
        let plusImg:UIImage = UIImage(named:"plus1")!

        let minusImgView = UIImageView(image:minusImg)
        let plusImgView = UIImageView(image:plusImg)
        let minusImgView2 = UIImageView(image:minusImg)
        let plusImgView2 = UIImageView(image:plusImg)
        let minusImgView3 = UIImageView(image:minusImg)
        let plusImgView3 = UIImageView(image:plusImg)
        
        
        let pad:CGFloat = 20.0
        let safeHeight = getSafeViewHeight().SafeViewHeight(UIScreen.main.bounds.size.height)
        let buttonHeight = ((safeHeight - 50.0) * 0.25 * 0.7 - 4.0) * 0.5
        
        minusImgView.frame = CGRect(x: 0, y: 0, width: buttonHeight - pad, height: buttonHeight - pad)
        plusImgView.frame = CGRect(x: 0, y: 0, width: buttonHeight - pad, height: buttonHeight - pad)
        minusImgView2.frame = CGRect(x: 0, y: 0, width: buttonHeight - pad, height: buttonHeight - pad)
        plusImgView2.frame = CGRect(x: 0, y: 0, width: buttonHeight - pad, height: buttonHeight - pad)
        minusImgView3.frame = CGRect(x: 0, y: 0, width: buttonHeight - pad, height: buttonHeight - pad)
        plusImgView3.frame = CGRect(x: 0, y: 0, width: buttonHeight - pad, height: buttonHeight - pad)
        
        let buttonViewWidth = (UIScreen.main.bounds.size.width - 26.0) * 0.25
        
        // 画像の中心を画面の中心に設定
        minusImgView.center = CGPoint(x:buttonViewWidth/4, y:buttonHeight/2)
        plusImgView.center = CGPoint(x:buttonViewWidth/4, y:buttonHeight/2)
        minusImgView2.center = CGPoint(x:buttonViewWidth/4, y:buttonHeight/2)
        plusImgView2.center = CGPoint(x:buttonViewWidth/4, y:buttonHeight/2)
        minusImgView3.center = CGPoint(x:buttonViewWidth/4, y:buttonHeight/2)
        plusImgView3.center = CGPoint(x:buttonViewWidth/4, y:buttonHeight/2)
        
        
            
        minusView1.addSubview(minusImgView)
        minusView2.addSubview(minusImgView2)
        minusView3.addSubview(minusImgView3)
        plusView1.addSubview(plusImgView)
        plusView2.addSubview(plusImgView2)
        plusView3.addSubview(plusImgView3)

    }
    

    //navigationBarのデリートボタンが押された時の処理
    @objc func clickDeleteButton(){
        _ = FMDBDatabaseModel.getInstanceKoma().updateDeleteKoma(tappedkoma:getKomaNum)

//        Util.invokeAlertMethod(strTitle: "", strBody: "recode updated !!", delegate: nil)
        
        _ = FMDBDatabaseModel.getInstanceSyusseki().deleteSyussekiHis(komaNum: getKomaNum)

        self.navigationController?.popViewController(animated: true)
        
        //削除ボタンを押した証
        delOrSave = 1
    }


    
    //txtRoom操作後のキーボードを閉じる処理
    //完了を押すとkeyboardを閉じる処理
    func textFieldShouldReturn(_ txt: UITextField) -> Bool {

        //Keyboardを閉じる
        txt.resignFirstResponder()

        return true
    }

    
    //txtVCom キーボード閉じる処理
    //doneボタンを押した時の処理
    @objc func doneButton(){
        //キーボードを閉じる
        self.view.endEditing(true)
    }

    //keyboard以外の画面を押すと、keyboardを閉じる処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.txtLec.isFirstResponder) {
            self.txtLec.resignFirstResponder()
        }else if(self.txtRoom.isFirstResponder){
            self.txtRoom.resignFirstResponder()
        }else if(self.txtVCom.isFirstResponder){
            self.txtVCom.resignFirstResponder()
        }
    }

    //textViewに変更があると呼ばれる
    func textViewDidChange(_ txtVCom: UITextView) {
        //一文字でも書かれたならばうっすら文字は消すよー
        placeholderLabel.isHidden = !txtVCom.text.isEmpty
        print(!txtVCom.text.isEmpty)
        print("変更！！")
    }

    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        //ここでUIKeyboardWillShowという名前の通知のイベントをオブザーバー登録をしている
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //ここでUIKeyboardWillHideという名前の通知のイベントをオブザーバー登録をしている
        NotificationCenter.default.addObserver(self, selector: #selector(DetailViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        return true
    }
    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillShow(_ notification: NSNotification){
    
        // NavigationBarを非表示
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        kyboardHeight = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
        safeViewHeight = getSafeViewHeight().SafeViewHeight(screenHeight)

        
        //頑張ってメモをいい感じの場所に移動させようとしたが、、、うまくいかなかったけど、、そこそこいい感じなので使う
        contentTop.constant = safeViewHeight * (-1) + ((safeViewHeight - 20.0) * 0.25 - kyboardHeight) + 80.0
        contentBottom.constant = ((safeViewHeight - 20.0) * 0.25 - kyboardHeight + 80.0) * 0.5
        
        syussekiView.alpha = 0
        rejumeView.alpha = 0

        UIView.animate(withDuration: 0.1,
                       animations:{
                        self.view.layoutIfNeeded()
                        
        })
        
    }
    
    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillHide(_ notification: NSNotification){
        
        // NavigationBarを非表示
        self.navigationController?.setNavigationBarHidden(false, animated: false)
 
        contentTop.constant = 0
        contentBottom.constant = 0
        
        syussekiView.alpha = 1.0
        rejumeView.alpha = 1.0
        
        UIView.animate(withDuration: 0.5,
                       animations:{
                        self.view.layoutIfNeeded()
                        
        })
        
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    

    @IBAction func btnShiraTapped(_ sender: Any) {
        print("aa")
    }
    
    @IBAction func btnColorTapped(_ sender: Any) {
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "selectNewColorViewController") as! selectNewColorViewController
        
        DV.getType = getType
        
        self.navigationController?.pushViewController(DV, animated: true)
    }
    
    
    //詳細、履歴を見る
    @IBAction func goHistory(_ sender: Any) {
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "syussekiViewController") as! syussekiViewController

        DV.getkomaNum = getKomaNum
        
        self.navigationController?.pushViewController(DV, animated: true)
        
    }
    
    

    //プラスマイナスボタン
    @IBAction func plusMinusTapped(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 1:
            userDefault.set(Int(syussekiCountLab.text!)! - 1, forKey: "syussekiCount")
        case 2:
            userDefault.set(Int(tikokuCountLab.text!)! - 1, forKey: "tikokuCount")
        case 3:
            userDefault.set(Int(kessekiCountLab.text!)! - 1, forKey: "kessekiCount")
        case 4:
            userDefault.set(Int(syussekiCountLab.text!)! + 1, forKey: "syussekiCount")
        case 5:
            userDefault.set(Int(tikokuCountLab.text!)! + 1, forKey: "tikokuCount")
        case 6:
            userDefault.set(Int(kessekiCountLab.text!)! + 1, forKey: "kessekiCount")
        default:
            true
        }

        
        syussekiCountLab.text = userDefault.string(forKey: "syussekiCount")
        tikokuCountLab.text = userDefault.string(forKey: "tikokuCount")
        kessekiCountLab.text = userDefault.string(forKey: "kessekiCount")
        
        
        
        let now = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        
        let stringData = formatter.string(from: now as Date)

        
        _ = FMDBDatabaseModel.getInstanceSyusseki().syussekiHistory(sender.tag,stringData,getKomaNum)
        
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn], animations: {
            switch sender.tag {
            case 1:
                self.minusView1.alpha = 0.7
            case 2:
                self.minusView2.alpha = 0.7
            case 3:
                self.minusView3.alpha = 0.7
            case 4:
                self.plusView1.alpha = 0.7
            case 5:
                self.plusView2.alpha = 0.7
            case 6:
                self.plusView3.alpha = 0.7
            default:
                true
                
            }
        }, completion: { _ in
            self.minusView1.alpha = 1.0
            self.minusView2.alpha = 1.0
            self.minusView3.alpha = 1.0
            self.plusView1.alpha = 1.0
            self.plusView2.alpha = 1.0
            self.plusView3.alpha = 1.0
        })
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("tobuyo--")
        
        //削除ボタンが押された時にはdelOrSaveが１になるので保存はされない
        if delOrSave != 1{
            _ = FMDBDatabaseModel.getInstanceKoma().updateKoma(lecture:txtLec.text!,room:txtRoom.text!,comment:txtVCom.text!,tappedkoma:getKomaNum, syussekiCount: Int(syussekiCountLab.text!)!, tikokuCount: Int(tikokuCountLab.text!)!, kessekiCount: Int(kessekiCountLab.text!)!)
        }
        
        
    }
    
    
    
}
