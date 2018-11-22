//
//  umeSothukeizaiViewController.swift
//  
//
//  Created by 山本シェーン on 2018/08/09.
//

import UIKit
import PopupDialog
import MMPopLabel

class umeSothukeizaiViewController: UIViewController,UITextFieldDelegate,MMPopLabelDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    
    @IBAction func unwindActionToUmeOnKeiz(segue: UIStoryboardSegue) {
        isTapped = 1
        if segue.identifier == "lecBtnToUmeOnKeiz"{
            textFieldBorderEnable(TorF: true)
        }else if segue.identifier == "barBackBtnToUmeOnKeiz"{
            textFieldBorderEnable(TorF: true)
        }
        
    }
    
    //UserDefaultsの宣言
    let userDefault = UserDefaults.standard
    
    //一番後ろのview、横サイズの基準に使う
    @IBOutlet var backViewKeiz: UIView!
    @IBOutlet weak var typeView: UIStackView!
    @IBOutlet weak var lecView: UIStackView!
    
    @IBOutlet weak var backOfTypeView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var typeRight: NSLayoutConstraint!
    @IBOutlet weak var typeTop: NSLayoutConstraint!
    @IBOutlet weak var typeBottom: NSLayoutConstraint!
    @IBOutlet weak var lecLeft: NSLayoutConstraint!
    @IBOutlet weak var lecTop: NSLayoutConstraint!
    @IBOutlet weak var lecBottom: NSLayoutConstraint!
    
    
    @IBOutlet var txtList: [UITextField]!
    
    @IBOutlet var typeLabList: [UILabel]!
    

    @IBOutlet var typeOne: [UILabel]!
    @IBOutlet var typeTwo: [UILabel]!
    @IBOutlet var typeFive: [UILabel]!
    

    //下の画像
    @IBOutlet weak var imgBottom: UIImageView!
    
    @IBOutlet weak var btnTwoOrThree: UIButton!
    
    @IBOutlet weak var btnOneFive: UIButton!
    
    //吹き出しラベル
    var fukiLabel: MMPopLabel!
    
    
    @IBOutlet weak var karakaraTop: NSLayoutConstraint!
    
    //カラカラとその上のバー
    @IBOutlet weak var karakara: UIPickerView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    //群選択がされていない時に表示されている薄いボタン
    let gunButton = UIButton()
    
    let gunnList:[String] = ["2群","3群"]
    

    var GetLecInfo = NSMutableArray()
    
    //画面街がタップされた時の判別
    var isTapped:Int = Int()
    
    //選択できる色の一覧
    var col = colorList()
    
    //スクリーンの高さ
    var screenHeight = CGFloat()
    //ナビゲーションバーの高さ
    var navigationBarHeight = CGFloat()
    //画面のセーフViewの上から一番下までの高さ
    var safeTopTobottom = CGFloat()
    //うめコマ１つの大きさ
    var umeKomaHeight = CGFloat()
    //キーボードを出した時にレイアウトをいじる境目
    var whereToKyboard = Int()
    //キーボードの高さ
    var kyboardHeight = CGFloat()
    //Xの時の下のはみ出し
    var bottomMargin = CGFloat()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //スクリーンの高さ
        screenHeight = UIScreen.main.bounds.size.height
        //ナビゲーションバーの高さ
        navigationBarHeight = (self.navigationController?.navigationBar.frame.size.height)!
        //画面のセーフViewの上から一番下までの高さ
        safeTopTobottom = screenHeight - navigationBarHeight
        umeKomaHeight = typeView.bounds.height / 18
        
        bottomMargin = screenHeight - typeView.bounds.height - navigationBarHeight * 2.0
        
        //キーボードの高さの取得
        getKyboardHeight()
        
        //吹き出しのセット
        setFukidashi()
        
        //専攻群のとこの文字の初期設定
        if (userDefault.string(forKey: "selectGunKeizai") != nil){
            typeTwo[0].text = userDefault.string(forKey: "selectGunKeizai")! + "選択※"
        }else{
            typeTwo[0].text = "2群3群選択※"
        }
    
        //カラカラをまずは隠す
        karakaraTop.constant = screenHeight
        
        //カラカラのDelegate設定
        karakara.delegate = self
        karakara.dataSource = self
        
        // Flexible Space Bar Button Item
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(umeSothukeizaiViewController.kannryoTapped))
        toolbar.setItems([flexibleItem,doneItem], animated: true)
        
        //ナビゲーションバーを表示
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        //編集ボタンのセット
        let editButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit"),style: .plain, target: self, action: #selector(umeSothuViewController.clickEditButton))
        //残りの単位数参照ボタンのセット
        let infoButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "umePop"),style: .plain, target: self, action: #selector(umeSothuViewController.clickInfoButton))
        self.navigationItem.setRightBarButtonItems([editButton,infoButton], animated: true)
        
        //背景画像
        imgBottom.image = backgroundList().getBackImg(UserDefaults.standard.integer(forKey: "backImg"))
        

        
        //表示の比率の設定
        typeRight.constant = backViewKeiz.bounds.width * 0.8
        lecLeft.constant = backViewKeiz.bounds.width * 0.2
        
        
        
        //textFieldの諸々設定
        textFieldSet()
        //textFieldを編集できないようにする
        textFieldBorderEnable(TorF: false)
        
        //データベースを読んで最新情報を更新
        reloadUme()
        
        
        //左のタイプラベルの大きさ
        for i in 0..<typeOne.count{
            typeOne[i].heightAnchor.constraint(equalTo: typeView.heightAnchor, multiplier: 1.0/18.0).isActive = true
        }
        for i in 0..<typeTwo.count{
            typeTwo[i].heightAnchor.constraint(equalTo: typeView.heightAnchor, multiplier: 2.0/18.0).isActive = true
        }
        for i in 0..<typeFive.count{
            typeFive[i].heightAnchor.constraint(equalTo: typeView.heightAnchor, multiplier: 5.0/18.0).isActive = true
        }
        
        for i in 0..<typeLabList.count{
            typeLabList[i].layer.borderWidth = 1.0
            typeLabList[i].layer.borderColor = UIColor.black.cgColor
        }
        
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        reloadUme()
    }
    
    
    
    
    //navigationBarの編集ボタンが押された時
    @objc func clickEditButton(){
        
        isTapped = 1
        
        //もし吹き出しが出ていたら消すのと、消すためのボタンも消す
        backButton.alpha = 0.0
        fukiLabel.dismiss()
        
        //保存ボタンのセット
        let saveButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "save"),style: .plain, target: self, action: #selector(umeSothuViewController.clickSaveButton))
        self.navigationItem.setRightBarButtonItems([saveButton], animated: true)
        
        self.title = "編集中"
        backOfTypeView.alpha = 0.5
        
        textFieldBorderEnable(TorF: true)
        
        
        for i in 0..<txtList.count{
            
            //何も書かれていない場合
            if (txtList[i].text?.isEmpty)!{
                //tagで押されたTFの位置を教える
                txtList[i].tag = i
                
                //2.3群の埋めのところで群が未選択の時は押したらカラカラを出す
                if (userDefault.integer(forKey: "selectGunKeizaiNum") == 0){
                    //専攻群のtextField
                    if i >= 18 && i <= 23{
                        txtList[i].addTarget(self, action: #selector(umeSothukeizaiViewController.twoOrThreeButton), for: .editingDidBegin)
                        continue
                    }
                    //群選択がされている時はカラカラ出す処理を削除しておく
                }else{
                    
                    txtList[i].removeTarget(self, action: #selector(umeSothukeizaiViewController.twoOrThreeButton), for: .editingDidBegin)
                }
                
                txtList[i].addTarget(self, action: #selector(umeSothukeizaiViewController.txtTapped(sender:)), for: .editingDidBegin)
                //txtTappedで処理をする
                
            }
        }
        
    }
    
    
    
    //押されたtexiFieldのタイプの講義が一覧になってるページに飛ぶ
    @objc func txtTapped(sender: UITextField){
        isTapped = 1
        
        
        //自由単位のところは選びきれないから入力にする
        if sender.tag < 39{
            //たまにclickEditButton()での空欄かどうかの条件分岐をすり抜けてくるのでもう一度条件分岐
            if (txtList[sender.tag].text?.isEmpty)! {
                let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let DV = MainStoryboard.instantiateViewController(withIdentifier: "lecTableFromKeizaiUmeViewController") as! lecTableFromKeizaiUmeViewController
                
                //どこのtextFieldが押されて画面遷移してるか教える（0~53）
                DV.getUmeNum = sender.tag
                
                self.navigationController?.pushViewController(DV, animated: true)
            }
        }
        
        
        
    }
    
    
    //残りの必要単位数が表示されるポップアップビュー
    @objc func clickInfoButton(){
        let vc = PopupKeizaiViewController(nibName: "PopupKeizaiViewController", bundle: nil)
        
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
        
        isTapped = 0
        
        //左のぼやかしを取ってあげる
        backOfTypeView.alpha = 0
        //タイトルを消す
        self.title = ""
        //編集できなくする
        textFieldBorderEnable(TorF: false)

        //再度読んであげる
        //編集ボタンのセット
        let editButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "edit"),style: .plain, target: self, action: #selector(umeSothuViewController.clickEditButton))
        let infoButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "umePop"),style: .plain, target: self, action: #selector(umeSothuViewController.clickInfoButton))
        self.navigationItem.setRightBarButtonItems([editButton,infoButton], animated: true)
    }
    
    
    //キーボードを閉じたあとに呼ばれる
    func textFieldDidEndEditing(_ textField:UITextField){
        print("キーボードを閉じたあと")
        var l = db_umekeizai()
        l = GetLecInfo.object(at: textField.tag) as! db_umekeizai
        //完了ボタンを押した時に文字にの編集が行なわれていた場合
        if l.umeLec != textField.text{
            _ = FMDBDatabaseModel.getInstanceUmeKeizai().umeUme(lecture: textField.text!, tappedNum: textField.tag + 1)
            
        }
        NotificationCenter.default.removeObserver(self,name: NSNotification.Name.UIKeyboardWillShow, object: nil)
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
            reloadUme()
            
        }
        
        
        
    }
    
    
    
    //テキストフィールがタップされ、入力可能になったあと
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isKeyboard(txtNum: textField.tag)
        print("テキストフィールがタップされ、入力可能になったあと")
        //テキストフィールに何か書いてあれば編集可能のまま
        //空欄ならば編集不可にする、そうしないと画面外をタップした時に
        if textField.tag < 39{
            for i in 0..<txtList.count{
                if !(txtList[i].text?.isEmpty)!{
                    continue
                }
                txtList[i].isEnabled = false
            }
            //自由単位のところはカラでも編集可能のまま
        }else{
            textFieldBorderEnableOfZiyuu(TorF: true)
        }
        
        
        
    }
    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillShow(_ notification: NSNotification){
        
        isTapped = 1
        
        // NavigationBarを非表示
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        
        kyboardHeight = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
        if screenHeight == 812.0{
            lecTop.constant = (kyboardHeight - bottomMargin) * (-1)
            typeTop.constant = (kyboardHeight - bottomMargin) * (-1)
            lecBottom.constant = kyboardHeight - bottomMargin
            typeBottom.constant = (kyboardHeight - bottomMargin) * (-1)
        }else{
            lecTop.constant = kyboardHeight * (-1)
            typeTop.constant = kyboardHeight * (-1)
            lecBottom.constant = kyboardHeight
            typeBottom.constant = kyboardHeight * (-1)
        }
        
        UIView.animate(withDuration: 0.1,
                       animations:{
                        self.view.layoutIfNeeded()
                        
        })
        
        
    }
    
    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillHide(_ notification: NSNotification){
        
        // NavigationBarを表示したい場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        lecTop.constant = 0
        lecBottom.constant = 0
        typeTop.constant = 0
        typeBottom.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       animations:{
                        self.view.layoutIfNeeded()
                        
        })
        
    }
    
    
    //かく埋めを最新情報に更新する
    func reloadUme(){
        GetLecInfo = FMDBDatabaseModel.getInstanceUmeKeizai().GetLecOfUme()
        
        for i in 0..<txtList.count{
            var l = db_umekeizai()
            l = GetLecInfo.object(at: i) as! db_umekeizai
            
            txtList[i].text = l.umeLec
        }
    }
    
    
    //ボーダーラインのスタイル、はっきりしたやつにした
    //textFieldの枠線の色指定、編集不可にすると色が薄くなるので再度指定
    //textFieldの枠の幅、textFieldBorderColorで色指定する時に枠に幅を持たせないと色が反映されない
    func textFieldSet(){
        for i in 0..<txtList.count{
            if i == 11 ||  i == 52 || i == 53{
                txtList[i].delegate = self
                txtList[i].borderStyle = .line
                txtList[i].layer.borderWidth = 1.0
                txtList[i].layer.backgroundColor = UIColor.clear.cgColor
            }else{
                txtList[i].delegate = self
                txtList[i].borderStyle = .line
                txtList[i].layer.borderColor = UIColor.black.cgColor
                txtList[i].layer.borderWidth = 1.0
                txtList[i].backgroundColor = UIColor.white
                txtList[i].font = .systemFont(ofSize: 12)
                //改行ボタンを完了ボタンに変更
                txtList[i].returnKeyType = .done
                txtList[i].tag = i
            }
            
        }
    }
    
    //textFieldを編集不可にする
    func textFieldBorderEnable(TorF:Bool){
        for i in 0..<txtList.count{
            if i == 11 ||  i == 52 || i == 53{
                txtList[i].isEnabled = false
            }else{
                txtList[i].isEnabled = TorF
            }
            
        }
    }
    
    func textFieldBorderEnableOfZiyuu(TorF:Bool){
        for i in 0..<txtList.count{
            if i >= 52{
                txtList[i].isEnabled = false
            }else if i >= 39{
                txtList[i].isEnabled = TorF
            }else{
                txtList[i].isEnabled = false
            }
        }
    }
    
    
    
    //キーボードが隠れるかの判定と監視
    func isKeyboard(txtNum:Int){
        
        //キーボードで隠れない部分の高さ
        let notKyboard = safeTopTobottom - kyboardHeight
        
        print(kyboardHeight)
        
        whereToKyboard = Int(notKyboard / umeKomaHeight) - 1
        
        print(txtNum)
        print(whereToKyboard)
        
        if txtNum >= whereToKyboard * 3 {
            //ここでUIKeyboardWillShowという名前の通知のイベントをオブザーバー登録をしている
            NotificationCenter.default.addObserver(self, selector: #selector(umeSothuViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            //ここでUIKeyboardWillHideという名前の通知のイベントをオブザーバー登録をしている
            NotificationCenter.default.addObserver(self, selector: #selector(umeSothuViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }else{
            print("そのまま")
        }
        
    }
    
    func getKyboardHeight(){
        kyboardHeight = getKeyboardHeight().getKeyHeight(screenHeight)
    }
    
    //吹き出しのセット
    func setFukidashi(){
        // ポップアップの背景色
        MMPopLabel.appearance().labelColor = #colorLiteral(red: 0.9312680364, green: 0.9955201745, blue: 0.662632525, alpha: 1)
        // ポップアップの文字色
        MMPopLabel.appearance().labelTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        // ポップアップの文字ハイライト時の色
        MMPopLabel.appearance().labelTextHighlightColor = UIColor.green
        // ポップアップの文字フォント
        MMPopLabel.appearance().labelFont = UIFont(name: "Kailasa-Bold", size: 10)
        // ポップアップのボタンの文字フォント
        MMPopLabel.appearance().buttonFont = UIFont(name: "Kailasa-Bold", size: 10)
        
        fukiLabel = MMPopLabel(text: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
        fukiLabel.delegate = self
        
        
        
        view.addSubview(fukiLabel)
    }
   
    //２群か３群か選択させる
    @IBAction func twoOrThreeButton(_ sender: UIButton) {
        fukiLabel = MMPopLabel(text: "2群か3群か選択して")
        let mess = UIButton(frame: CGRect.zero)
        mess.setTitle(NSLocalizedString("12単位埋めてください", comment: "mess Button"), for: .normal)
        fukiLabel.add(mess)
        btnTwoOrThree.addSubview(fukiLabel)
        
        fukiLabel.pop(at: sender)
        
        //かげ
        fukiLabel.layer.shadowOffset = CGSize(width: 10,height: 10) // 影の位置
        fukiLabel.layer.shadowColor = UIColor.black.cgColor       // 影の色
        fukiLabel.layer.shadowOpacity = 1                       // 影の透明度
        fukiLabel.layer.shadowRadius = 20                        // 影の広がり
        
        backOfTypeView.alpha = 0.5
        backButton.alpha = 1.0
        
        //選択させるためのカラカラを出す
        karakaraTop.constant =  typeView.bounds.height - umeKomaHeight * 4
        
        UIView.animate(withDuration: 0.5,
                       animations:{
                        self.view.layoutIfNeeded()
                        
        })
    }
    
    //１〜５群
    @IBAction func oneFiveButton(_ sender: UIButton) {
        fukiLabel = MMPopLabel(text: "1~5群から自由に")
        let mess = UIButton(frame: CGRect.zero)
        mess.setTitle(NSLocalizedString("30単位埋めてください", comment: "mess Button"), for: .normal)
        fukiLabel.add(mess)
        btnOneFive.addSubview(fukiLabel)
        
        fukiLabel.pop(at: sender)
        
        //かげ
        fukiLabel.layer.shadowOffset = CGSize(width: 10,height: 10) // 影の位置
        fukiLabel.layer.shadowColor = UIColor.black.cgColor       // 影の色
        fukiLabel.layer.shadowOpacity = 1                       // 影の透明度
        fukiLabel.layer.shadowRadius = 20                        // 影の広がり
        
        backOfTypeView.alpha = 0.5
        backButton.alpha = 1.0
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        fukiLabel.dismiss()
        backOfTypeView.alpha = 0.0
        backButton.alpha = 0.0
        
        //カラカラしまう
        karakaraTop.constant = screenHeight
        
        //専攻群の埋めのところの薄いボタンを消しちゃう
        if (userDefault.integer(forKey: "selectGunKeizaiNum") != 0){
            gunButton.alpha = 0.0
            
            self.lecView.addSubview(gunButton)
            print("透明にするよ")
        }

        
        UIView.animate(withDuration: 0.2,
                       animations:{
                        self.view.layoutIfNeeded()
                        
        })
        
        reloadGunnSelect()
        
    }
    
    
    //群選択がされているかの判定と更新
    func reloadGunnSelect(){
        for i in 0..<txtList.count{
            
            //何も書かれていない場合
            if (txtList[i].text?.isEmpty)!{
                
                //2.3群の埋めのところで群が未選択の時は押したらカラカラを出す
                if (userDefault.integer(forKey: "selectGunKeizaiNum") == 0){
                    //専攻群のtextField
                    if i >= 18 && i <= 23{
                        txtList[i].addTarget(self, action: #selector(umeSothukeizaiViewController.twoOrThreeButton), for: .editingDidBegin)
                        continue
                    }
                    //群選択がされている時はカラカラ出す処理を削除しておく
                }else{
                    
                    txtList[i].removeTarget(self, action: #selector(umeSothukeizaiViewController.twoOrThreeButton), for: .editingDidBegin)
                }
                
                txtList[i].addTarget(self, action: #selector(umeSothukeizaiViewController.txtTapped(sender:)), for: .editingDidBegin)
                //txtTappedで処理をする
                
            }
        }
    }
    
    //この下からカラカラ関係
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return gunnList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return gunnList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        userDefault.set(row + 5,forKey:"selectGunKeizaiNum")
        userDefault.set(gunnList[row],forKey:"selectGunKeizai")
        
        typeTwo[0].text = userDefault.string(forKey: "selectGunKeizai")! + "選択※"
        
    }
    
    
    //カラカラの上のバーの完了ボタン
    @objc func kannryoTapped(){

        
        backButtonTapped((Any).self)
    }


}
