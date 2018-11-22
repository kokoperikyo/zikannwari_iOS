
//
//  ViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/10.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit
import PopupDialog

class komaViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBAction func unwindAction(segue: UIStoryboardSegue) {
        if segue.identifier == "regToKoma"{
            
        }else if segue.identifier == "allLecToKoma"{
            
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
        }else if segue.identifier == "allLecRegToKoma"{
            
            //ここでスライド画面が左側にすっぽりと消える
            left.constant = backView.bounds.width * (-1)
            right.constant = backView.bounds.width
            
            //スライド消す用ボタンは一番下の見えないとこへ
            backgroundButton.alpha = 0
            
        }
        
    }
    //初めからある一番後ろのView
    @IBOutlet var backView: UIView!

    //iphoneXの時に見える下の隙間を埋める画像View
    @IBOutlet weak var imgBottom: UIImageView!

    
    //safeViewと同じもの、黒染めして枠線っぽくする
    @IBOutlet weak var blackView: UIView!
    //左上の余白
    @IBOutlet weak var yohakuView: UIView!
    //曜日
    @IBOutlet weak var youbiView: UIStackView!
    //時限
    @IBOutlet weak var zigennView: UIStackView!
    
  
    //コマの内側のやつ、コマに対してpaddingをつけているやつ、色指定に使う
    @IBOutlet var komaColorView: [UIView]!
    //講義
    @IBOutlet var labLec: [UILabel]!
    //教室labelを入れてるやつ
    @IBOutlet var ViewRoom: [UIView]!
    //教室
    @IBOutlet var labRoom: [UILabel]!
    
    
    
    //スライドしてくるviewの左と右のパディング
    @IBOutlet weak var left: NSLayoutConstraint!
    @IBOutlet weak var right: NSLayoutConstraint!
    //スライドして出てくるViewの背景画像
    @IBOutlet weak var imgSuraid: UIImageView!
    //いつもは隠れててスライドを出すとスライド以外の画面に半透明で出現
    @IBOutlet weak var backgroundButton: UIButton!
    
    
    //スライド画面のボタンリスト
    @IBOutlet var btnSuraidList: [UIButton]!
    
    
    //カラカラとバーが入っているView
    @IBOutlet weak var karakaraView: UIView!
    //カラカラの上のバー
    @IBOutlet weak var toolbarOfName: UIToolbar!
    //カラカラ
    @IBOutlet weak var karakaraOfName: UIPickerView!
    //カラカラだしいれ上
    @IBOutlet weak var karakaraTop: NSLayoutConstraint!
    
    
    //初回View
    @IBOutlet weak var syokaiView: UIView!
    //初回起動時に表示される学科選択View
    @IBOutlet weak var seleGakkaView: UIView!
    //初回起動時に表示される学科選択Viewの背景画像
    @IBOutlet weak var imgsyokai: UIImageView!
    
    
    
    
    //初回かの判定
    // UserDefaultsを使ってフラグを保持する
    let userDefault = UserDefaults.standard


    var allBackView  = UIImage()

    
    //宣言,講義が入ってるデータベースの全権取得
    var GetDataInfoKoma = NSMutableArray()
    //色を定義してるデータベース
    var GetDataInfoKomaColor = NSMutableArray()
    //時間割の名前のデータベース
    var GetAllDataInfoOfZikannName = NSMutableArray()
    

    //スライドを出すかしまうか判断する
    var whichSuraidInOut = 1
    
    //ポップアップViewが新規作成か編集か分ける
    static var whichpop:Int = Int()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // "firstLaunch"をキーに、Bool型の値を保持する
        let dict = ["firstLaunch": true]
        // デフォルト値登録
        // ※すでに値が更新されていた場合は、更新後の値のままになる
        userDefault.register(defaults: dict)
        
        // "firstLaunch"に紐づく値がtrueなら(=初回起動)、値をfalseに更新して処理を行う
        if userDefault.bool(forKey: "firstLaunch") {
            
            //エラー出さないためにひとまず経営学科にしとく、すぐに選択して
            userDefault.set(1,forKey:"gakkaNum")
            // NavigationBarを隠す
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            syokaiView.alpha = 1.0
            
            //初回は背景画像の数字に白のやつを入れておく
            userDefault.set(backgroundList().getListNum() - 1, forKey: "backImg")
            //記憶された時間割のどれにアクセスするか、初回は0を入れておく
            userDefault.set(0, forKey: "zikannNum")
        }

        
        //背景画像を減らした時のエラー対策
        if userDefault.integer(forKey: "backImg") > backgroundList().getListNum() || userDefault.bool(forKey: "firstLaunch"){
            imgBottom.image = backgroundList().getBackImg(userDefault.integer(forKey: "backImg"))
        }else{
            //背景画像
            imgBottom.image = backgroundList().getBackImg(userDefault.integer(forKey: "backImg"))
        }

        
        //スライドの背景画像
        imgSuraid.image = UIImage(named: "umi1")
        
        
        //コマの情報を取得
        GetDataInfoKoma = FMDBDatabaseModel.getInstanceKoma().GetAllDataOfKoma()
        //時間割の名前の情報を取得
        GetAllDataInfoOfZikannName = FMDBDatabaseModel.getInstanceZikannName().GetAllDataOfZikannName()

        // ナビゲーションを透明にする処理
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //バーのアイテムの色、ボタンとかアイコンとか
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        
        imgsyokai.image = UIImage(named: "syokai")
        
        //レイアウト
        NSLayoutConstraint.activate([
        yohakuView.heightAnchor.constraint(equalTo: blackView.heightAnchor, multiplier: 0.03),
        yohakuView.widthAnchor.constraint(equalTo: blackView.widthAnchor, multiplier: 0.1),
        youbiView.heightAnchor.constraint(equalTo: blackView.heightAnchor, multiplier: 0.03),
        zigennView.widthAnchor.constraint(equalTo: blackView.widthAnchor, multiplier: 0.1),
        seleGakkaView.widthAnchor.constraint(equalTo: blackView.widthAnchor, multiplier: 0.8),
            ])
        
        
        //学科選択Viewのかげ
        seleGakkaView.layer.shadowOffset = CGSize(width: 10,height: 10) // 影の位置
        seleGakkaView.layer.shadowColor = #colorLiteral(red: 0.2138669491, green: 0.2122896314, blue: 0.2150782347, alpha: 1)       // 影の色
        seleGakkaView.layer.shadowOpacity = 1                       // 影の透明度
        seleGakkaView.layer.shadowRadius = 10                        // 影の広がり
        

        //コマの中身のレイアウト
        for i in 0..<komaColorView.count{
            //コマの中の要素のレイアウト
            labLec[i].heightAnchor.constraint(equalTo: komaColorView[i].heightAnchor, multiplier: 0.8).isActive = true
            ViewRoom[i].heightAnchor.constraint(equalTo: komaColorView[i].heightAnchor, multiplier: 0.2).isActive = true
            
            //labelのテキストの位置を真ん中に
            labLec[i].textAlignment = NSTextAlignment.center
            labRoom[i].textAlignment = NSTextAlignment.center
            
            //講義の名前が見切れないようにフォントを小さくして、改行をさせる
            labLec[i].font = UIFont.systemFont(ofSize: 15.0)
            labLec[i].numberOfLines = 0
        }
        

        
        //ここでスライド画面が左側にすっぽりと消える
        left.constant = backView.bounds.width * (-1)
        right.constant = backView.bounds.width
        
        //１年生の時には埋め卒は薄くする
        if userDefault.integer(forKey: "gakkaNum") == 4{
            btnSuraidList[1].alpha = 0.5
        }

 
        //スライドを出すアイコンボタン
        let suraidButton = UIBarButtonItem(image: UIImage(named: "menu"),style: .plain, target: self, action: #selector(komaViewController.getSuraid))
        self.navigationItem.leftBarButtonItem = suraidButton
        

        
        //スライド画面のボタン
        for i in 0..<btnSuraidList.count{
            //かげ
            btnSuraidList[i].layer.shadowOffset = CGSize(width: 10,height: 10) // 影の位置
            btnSuraidList[i].layer.shadowColor = #colorLiteral(red: 0.2138669491, green: 0.2122896314, blue: 0.2150782347, alpha: 1)       // 影の色
            btnSuraidList[i].layer.shadowOpacity = 1                       // 影の透明度
            btnSuraidList[i].layer.shadowRadius = 10                        // 影の広がり
        }

        
        
        //カラカラ
        karakaraOfName.delegate = self
        karakaraOfName.dataSource = self
        
        //カラカラを隠す
        karakaraTop.constant = view.bounds.height
        
        //カラカラようの時間割の名前をセット
        reloadKarakara()
        
        //カラカラの上のバー
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(komaViewController.kannryoTapped))
        let editItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(komaViewController.editZikannNametapped))
        toolbarOfName.setItems([doneItem,editItem], animated: true)
    
        
        //タイトル(ボタン)
        makeTitleButton()
        
        //前期と後期
        zennkiOrKouki()
        

        
        
        //スライドを出すアイコンボタン
        let gakkaButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(komaViewController.gakkaTap))
        self.navigationItem.rightBarButtonItem = gakkaButton
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        komaLoad()
        

    }
    
    //コマの情報を更新
    func komaLoad(){
        GetDataInfoKoma = FMDBDatabaseModel.getInstanceKoma().GetAllDataOfKoma()
        //コマにデータベースの中身を表示
        for i in 0..<komaColorView.count{
            var l = db_koma()
            l = GetDataInfoKoma.object(at: i) as! db_koma
            
            labLec[i].text = l.lecture
            labRoom[i].text = l.room
            
            
            
            GetDataInfoKomaColor = FMDBDatabaseModel.getInstanceColorType().GetDataOfColorTyoe(l.type)
            
            
            var li = db_colorType()
            li = GetDataInfoKomaColor.object(at: 0) as! db_colorType
            
            
            komaColorView[i].backgroundColor = colorList().targetColor(li.color)

        }
    }
    

    //時間割のコマが押させた時
    @IBAction func komaTapped(_ sender: UIButton) {
        GetDataInfoKoma = FMDBDatabaseModel.getInstanceKoma().GetAllDataOfKoma()
        var l = db_koma()
        l = GetDataInfoKoma.object(at: sender.tag) as! db_koma
        
        let komaNum:Int = sender.tag

        //遷移
        if l.lecture.isEmpty{
            let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let DV = MainStoryboard.instantiateViewController(withIdentifier: "lecViewController") as! lecViewController
        
            DV.getNum = komaNum

            
            self.navigationController?.pushViewController(DV, animated: true)
            
        }else{
            let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let DV = MainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
            print(l.syussekiCount)
            
            DV.getLec = l.lecture
            DV.getRoom = l.room
            DV.getteacher = l.teacher
            DV.getCom = l.comment
            DV.getType = l.type
            DV.getSyussekiCount = l.syussekiCount
            DV.getTikokuCount = l.tikokuCount
            DV.getKessekiCount = l.kessekiCount
            DV.getKomaNum = komaNum
        
            self.navigationController?.pushViewController(DV, animated: true)
        }
    }
    
    
    
    //バーの左端のボタンを押した時の処理、スライドを出し入れする
    @objc func getSuraid(){
        if whichSuraidInOut == 1{
            left.constant = 0
            right.constant = backView.bounds.width * 0.2
            
            //かげ
            imgSuraid.layer.shadowOffset = CGSize(width: 20,height: 0) // 影の位置
            imgSuraid.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)       // 影の色
            imgSuraid.layer.shadowOpacity = 1                       // 影の透明度
            imgSuraid.layer.shadowRadius = 3                        // 影の広がり
            
            UIView.animate(withDuration: 0.5,
                           animations:{
                            self.view.layoutIfNeeded()
                            
            })
            
            backgroundButton.alpha = 0.5
            
            whichSuraidInOut = 2
        }else{
            //スライドをしまう
            left.constant = backView.bounds.width * (-1)
            right.constant = backView.bounds.width
            karakaraTop.constant = view.bounds.height
            
            //かげを消す
            imgSuraid.layer.shadowOffset = CGSize(width: 0,height: 0) //
            
            UIView.animate(withDuration: 0.5,animations:{self.view.layoutIfNeeded()
                
            })
            
            backgroundButton.alpha = 0
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            
            whichSuraidInOut = 1
            
        }
        
        

    }
    
    //カラカラ
    //時間割の名前がからのやつを排除した配列
    var zikannNameArray:[String] = []
    //時間割に振られている番号
    var NumOfzikannNameArray:[Int] = []
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        
        return GetAllDataInfoOfZikannName.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int,forComponent component: Int) -> String? {

        return zikannNameArray[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int,inComponent component: Int) {
        //時間割の名前にアクセスする数字を変更
        
        
        userDefault.set(NumOfzikannNameArray[row], forKey: "zikannNum")
        //タイトルボタンの文字を更新
        makeTitleButton()
        self.komaLoad()
        
        print(NumOfzikannNameArray[row])
        
    }
    
    
    //カラカラの更新
    func reloadKarakara(){
        
        //初期化
        zikannNameArray = []
        //初期化
        NumOfzikannNameArray = []
        
        for i in 0..<GetAllDataInfoOfZikannName.count{
            var l = db_zikannName()
            l = GetAllDataInfoOfZikannName.object(at: i) as! db_zikannName
            
            zikannNameArray.append(l.name)
            NumOfzikannNameArray.append(l.num)
            
        }
    }
    //カラカラ終了
    
    //カラカラの上のバーの完了ボタンが押された時
    @objc func kannryoTapped(){
        
        //カラカラをしまう
        karakaraTop.constant = view.bounds.height
        UIView.animate(withDuration: 0.5, animations: {self.view.layoutIfNeeded()
            
        })
        
        backgroundButton.alpha = 0
    }
    
    
    //カラカラの上のバーの編集ボタンが押された時
    @objc func editZikannNametapped(){
        komaViewController.whichpop = 2
        
        
        // ポップアップに表示したいビューコントローラー
        let vc = addZIkannPopupViewController(nibName: "addZIkannPopupViewController", bundle: nil)
        // 表示したいビューコントローラーを指定してポップアップを作る
        let popup = PopupDialog(viewController: vc)
        
        // OKボタンを作る
        let buttonOK = DefaultButton(title: "完了") {
            //時間割りの名前を登録する
            _ = FMDBDatabaseModel.getInstanceZikannName().putZikannName(name: addZIkannPopupViewController.zikannNameTxt)
            
            //時間割の名前の情報を更新
            self.GetAllDataInfoOfZikannName = FMDBDatabaseModel.getInstanceZikannName().GetAllDataOfZikannName()
            self.makeTitleButton()
            self.reloadKarakara()
            self.karakaraOfName.reloadAllComponents()
        }
        // ポップアップにボタンを追加
        popup.addButton(buttonOK)
        // 作成したポップアップを表示する
        present(popup, animated: true, completion: nil)
        
    }
    
    
    //タイトルの位置にあるボタンの作成
    func makeTitleButton(){
        //タイトルの大きさ
        let widthOfTitle = self.view.bounds.width * 0.6

        //ボタン
        let button = UIButton()
        let buttonText = getButtonText()
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //ボタンのサイズとその始点について
        //まずは可変に設定してあげる
        button.sizeToFit()
        //可変に設定したボタンがtitleViewを超えないならばそのまま可変
        if button.bounds.width < widthOfTitle{
            print(button.bounds.width)
        }else{//超えるならばボタンの大きさを中に入りきるようにしてあげる、右につけるアイコンがはみ出ないようにひと工夫
            button.frame.size = CGSize(width: widthOfTitle, height: 30.0)
        }
//        button.center = CGPoint(x: self.view.frame.size.width * 0.5, y: 22.0)
        button.addTarget(self, action: #selector(komaViewController.titileButtonAction), for: .touchUpInside)
        
        
        let titleView = UIView()
        titleView.frame.size = CGSize(width: widthOfTitle, height: 44)
        titleView.addSubview(button)
        button.center = CGPoint(x: widthOfTitle * 0.5, y: 22.0)
        
        //タイトルのいちにセット
        self.navigationItem.titleView = titleView
    }
    

    //タイトルボタンが押された時
    @objc func titileButtonAction(){
        //カラカラを出す
        karakaraTop.constant = view.bounds.height * 0.6
        
        //かげ
        karakaraView.layer.shadowOffset = CGSize(width: 0,height: -10) // 影の位置
        karakaraView.layer.shadowColor = UIColor.black.cgColor       // 影の色
        karakaraView.layer.shadowOpacity = 1                       // 影の透明度
        karakaraView.layer.shadowRadius = 20                        // 影の広がり
        
        UIView.animate(withDuration: 0.5, animations: {self.view.layoutIfNeeded()
            
        })
        backgroundButton.alpha = 0.5
        

    }
    
    
    //タイトルボタンの文字
    func getButtonText() -> String{
        
        var l = db_zikannName()
        l = FMDBDatabaseModel.getInstanceZikannName().GetAllDataOfZikannName().object(at: userDefault.integer(forKey: "zikannNum")) as! db_zikannName
        
        return l.name + "▼"
    }
    
    
    //透明になってるところを押したらスライドが消える
    @IBAction func btnClose(_ sender: Any) {
        left.constant = backView.bounds.width * (-1)
        right.constant = backView.bounds.width
        karakaraTop.constant = view.bounds.height
        
        //かげを消す
        imgSuraid.layer.shadowOffset = CGSize(width: 0,height: 0) //
        
        UIView.animate(withDuration: 0.5,animations:{self.view.layoutIfNeeded()
                        
        })
        
        backgroundButton.alpha = 0
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        whichSuraidInOut = 1
    }
    
    
    //初回表示の学科ボタンが押された時
    @IBAction func btnGakka(_ sender: UIButton) {
        let userDefault = UserDefaults.standard
        userDefault.set(sender.tag,forKey:"gakkaNum")
        
        // NavigationBarを隠す
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        syokaiView.alpha = 0.0
        
        //押された初めて初回起動判定から抜ける
        userDefault.set(false, forKey: "firstLaunch")
        
    }
    
    //ここで日にちによって前期後期を条件分岐する
    //今回は１が前期２が後期
    func zennkiOrKouki(){
        userDefault.set(2, forKey: "zennkiOrKouki")
    }
    
    

    
    
    //以下はスライドのボタン
    
    @IBAction func allLecTap(_ sender: Any) {
    
        
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "allLecViewController") as! allLecViewController
        
        
        self.navigationController?.pushViewController(DV, animated: true)
    }
    
    @IBAction func umerebaTap(_ sender: Any) {
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        switch userDefault.integer(forKey: "gakkaNum") {
            
        case 1:
            let DV = MainStoryboard.instantiateViewController(withIdentifier: "umeSothukeieiViewController") as! umeSothuViewController
            self.navigationController?.pushViewController(DV, animated: true)
        case 2:
            let DV = MainStoryboard.instantiateViewController(withIdentifier: "umeSothukeizaiViewController") as! umeSothukeizaiViewController
            self.navigationController?.pushViewController(DV, animated: true)
        case 3:
            let DV = MainStoryboard.instantiateViewController(withIdentifier: "umeSothukokusaiViewController") as! umeSothukokusaiViewController
            self.navigationController?.pushViewController(DV, animated: true)
        default:
            print("wow")
            // アラート作成
            let alert = UIAlertController(title: "", message: "学科が決まってから使えるようになります", preferredStyle: .alert)
            
            // アラート表示
            self.present(alert, animated: true, completion: {
                // アラートを閉じる
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    alert.dismiss(animated: true, completion: nil)
                })
            })
        }
        
    }
    
    
    @IBAction func colorOfType(_ sender: Any) {
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "colorViewController") as! colorViewController
        
        
        self.navigationController?.pushViewController(DV, animated: true)
    }
    
    
    @IBAction func btnBackgroundImg(_ sender: Any) {
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "backImgViewController") as! backImgViewController
        
        
        self.navigationController?.pushViewController(DV, animated: true)
    }
    
    
    @objc func gakkaTap(){
        let now = userDefault.integer(forKey: "gakkaNum")
        switch now % 5 {
        case 1:
            userDefault.set(2, forKey: "gakkaNum")
        case 2:
            userDefault.set(3, forKey: "gakkaNum")
        case 3:
            userDefault.set(4, forKey: "gakkaNum")
        case 4:
            userDefault.set(5, forKey: "gakkaNum")
        case 0:
            userDefault.set(1, forKey: "gakkaNum")
        default:
            true
        }
        
        
        
    }
    

}

