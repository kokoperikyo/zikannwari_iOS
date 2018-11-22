//
//  backImgViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/29.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit


final class backImgViewController: UIViewController {
    //スクロールするcollectionView
    var carouselView:CarouselView!
    //戻るボタン
    var backButton:UIButton!
    //戻るボタンの後ろ
    var XbackView:UIView!
    //バツボタンのView
    var XimgView:UIImageView!
    //バツボタンの画像
    var Xmark = UIImage(named: "X1")!
    //押すと画面遷移するボタン
    var backSenniButton:UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // NavigationBarを表示したい場合
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        
        //collectionView
        carouselView = CarouselView(frame: CGRect(x:0, y:0 ,width:width, height:height))
        //中心の設定、いじらない！
        carouselView.center = CGPoint(x:width / 2,y: height / 2)
        
        //バツ画像の後ろ
        XbackView = UIView()
        XbackView.frame = CGRect(x:0,y:0,width:60,height:60)
        XbackView.center = CGPoint(x:width / 2,y: height * 0.91)
        XbackView.layer.cornerRadius = 30
        XbackView.backgroundColor = UIColor.white
        //かげ
        XbackView.layer.shadowOffset = CGSize(width: 10,height: 10) // 影の位置
        XbackView.layer.shadowColor = #colorLiteral(red: 0.2138669491, green: 0.2122896314, blue: 0.2150782347, alpha: 1)       // 影の色
        XbackView.layer.shadowOpacity = 1                       // 影の透明度
        XbackView.layer.shadowRadius = 10                        // 影の広がり
        
        //バツ画像
        XimgView = UIImageView()
        XimgView.frame = CGRect(x:0,y:0,width:60,height:60)
        XimgView.center = CGPoint(x:width / 2,y: height * 0.91)
        XimgView.layer.cornerRadius = 30
        XimgView.image = Xmark
        
        
        //戻るボタン
        backButton = UIButton()
        backButton.frame = CGRect(x:0,y:0,width:60,height:60)
        backButton.center = CGPoint(x:width / 2,y: height * 0.91)
        backButton.layer.cornerRadius  = 30
        backButton.backgroundColor = UIColor.clear
        backButton.addTarget(self, action: #selector(backImgViewController.backButtonTapped), for: .touchUpInside)
        backButton.layer.borderWidth = 5.0
        backButton.layer.borderColor = UIColor.black.cgColor

        

        

        self.view.addSubview(carouselView)
        self.view.addSubview(XbackView)
        self.view.addSubview(XimgView)
        self.view.addSubview(backButton)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        carouselView.scrollToFirstItem()
    }
    
    @objc func backButtonTapped(){
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "komaViewController") as! komaViewController

        self.navigationController?.pushViewController(DV, animated: false)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

    }
    
}

final class CarouselView: UICollectionView {
    
    
    let cellIdentifier = "carousel"
    let pageCount = backgroundList().getListNum()
    let isInfinity = true
    var cellItemsWidth: CGFloat = 0.0
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.register(CarouselCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    convenience init(frame: CGRect) {
        let layout = PagingPerCellFlowLayout()
        //セルの大きさ
        layout.itemSize = CGSize(width: frame.width * 0.6, height: (frame.width * 0.6) * 2.06)
        layout.scrollDirection = .horizontal
        
        self.init(frame: frame, collectionViewLayout: layout)
        
        // 水平方向のスクロールバーを非表示にする
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = UIColor.white
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 画面内に表示されているセルを取得
        let cells = self.visibleCells
        for cell in cells {
            // ここでセルのScaleを変更する
            transformScale(cell: cell)
        }
    }
    
    
    //スクロール時のセルの大きさの変更
    func transformScale(cell: UICollectionViewCell) {
        let cellCenter:CGPoint = self.convert(cell.center, to: nil) //セルの中心座標
        let screenCenterX:CGFloat = UIScreen.main.bounds.width / 2  //画面の中心座標x
        let reductionRatio:CGFloat = -0.0009                        //縮小率
        let maxScale:CGFloat = 1                                    //最大値
        let cellCenterDisX:CGFloat = abs(screenCenterX - cellCenter.x)   //中心までの距離
        let newScale = reductionRatio * cellCenterDisX + maxScale   //新しいスケール
        cell.transform = CGAffineTransform(scaleX:newScale, y:newScale)
    }
    
    // 初期位置を真ん中にする
    func scrollToFirstItem() {
        self.layoutIfNeeded()
        if isInfinity {
            self.scrollToItem(at:IndexPath(row: self.pageCount, section: 0) , at: .centeredHorizontally, animated: false)
        }
    }
    
}

extension CarouselView: UICollectionViewDelegate {
    
    
    
}

extension CarouselView: UICollectionViewDataSource {
    
    
    
    
    
    // セクションごとのセル数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isInfinity ? pageCount * 3 : pageCount
    }
    
    // セルの設定
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CarouselCell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CarouselCell
        
        configureCell(cell: cell, indexPath: indexPath)
        
        // セルがタップされたときのaction
        cell.backButton.addTarget(self,action: #selector(self.buttonTapped(cell:)),for: .touchUpInside)
        
        
        return cell
    }
    
    
    func configureCell(cell: CarouselCell,indexPath: IndexPath) {
        // indexを修正する
        let fixedIndex = isInfinity ? indexPath.row % pageCount : indexPath.row
        
        // 背景ボタンにIndexをつける
        cell.backButton.tag = fixedIndex
        
        
        //画像
        //背景
        cell.backImg.image = backgroundList().getBackImg(fixedIndex)
        //実機にフレーム
        cell.img.image = iPhoneFrame().getFrameImg(fixedIndex)
        
    }
    
    //ボタン(セルが押された時)
    @objc func buttonTapped(cell : CarouselCell) {
        //画像の数字を保存
        UserDefaults.standard.set(cell.tag,forKey:"backImg")
        
        let cellwidth = cell.frame.size.width
        let cellheight = cell.frame.size.height
        
        //画像の背景を白にするためにview
        let popbackView = UIView()
        popbackView.backgroundColor = UIColor.white
        popbackView.frame = CGRect(x:0,y:0,width:150,height:150)
        popbackView.center = CGPoint(x:cellwidth / 2,y:cellheight / 2)
        popbackView.layer.cornerRadius = 70
        popbackView.alpha = 1.0
        popbackView.layer.shadowOffset = CGSize(width: 10,height: 10) // 影の位置
        popbackView.layer.shadowColor = #colorLiteral(red: 0.2138669491, green: 0.2122896314, blue: 0.2150782347, alpha: 1)       // 影の色
        popbackView.layer.shadowOpacity = 1                       // 影の透明度
        popbackView.layer.shadowRadius = 10                        // 影の広がり

        //選択した時に表示する画像
        //アニメーション
        let popView = UIImageView()
        popView.image = UIImage(named: "check")
        popView.frame = CGRect(x:0,y:0,width:150,height:150)
        popView.center = CGPoint(x:cellwidth / 2,y:cellheight / 2)
        popView.layer.cornerRadius = 70
        popView.alpha = 1.0
        
     
//        ここでアニメーションけく
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            popbackView.alpha = 0.0
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            popView.alpha = 0.0
        }, completion: nil)
        

        cell.addSubview(popbackView)
        cell.addSubview(popView)
        
    }
    
   
    
    
    
}

extension CarouselView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isInfinity {
            if cellItemsWidth == 0.0 {
                cellItemsWidth = floor(scrollView.contentSize.width / 3.0) // 表示したい要素群のwidthを計算
            }
            
            if (scrollView.contentOffset.x <= 0.0) || (scrollView.contentOffset.x > cellItemsWidth * 2.0) { // スクロールした位置がしきい値を超えたら中央に戻す
                scrollView.contentOffset.x = cellItemsWidth
            }
        }
        
        
        
    }
    
}

