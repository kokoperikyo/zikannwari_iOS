//
//  selectColorViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/05.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class selectColorViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    var cellSize:CGFloat = 0
    
    //渡ってきた選択されたタイプ番号1~10
    var getType:Int = Int()
    
    //選択できる色の一覧
    var col = colorList()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    //セルの大きさ、いまいちセル間のスペースの付け方がわからない、、とりあえずMinSpacingは１２で12＊2=24 24/3*2=16ってわけで感覚を16だとしてる
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横方向のスペース調整
        let horizontalSpace:CGFloat = 16
        cellSize = self.view.bounds.width / 3.0 - horizontalSpace
        
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24 //ここは手動
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        
        //セルのサイズの半分で丸みをつければ正方形は丸になる
        cell.layer.cornerRadius = cellSize/2.0
        
        
        //丸色の表示
        cell.backgroundColor = col.targetColor(indexPath.row)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(getType)
        print(indexPath.row)
        print("-----------")
        
        _ = FMDBDatabaseModel.getInstanceColorType().updateColor(type: getType, color: indexPath.row)
        
        
    }

    
    



}
