//
//  selectNewColorViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/07.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class selectNewColorViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

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
        cellSize = self.view.bounds.width/3.0 - horizontalSpace
        
        // 正方形で返すためにwidth,heightを同じにする
        return CGSize(width: cellSize, height: cellSize)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath)
        
        //セルのサイズの半分で丸みをつければ正方形は丸になる
        cell.layer.cornerRadius = cellSize/2.0
        
        
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = col.col1
        case 1:
            cell.backgroundColor = col.col2
        case 2:
            cell.backgroundColor = col.col3
        case 3:
            cell.backgroundColor = col.col4
        case 4:
            cell.backgroundColor = col.col5
        case 5:
            cell.backgroundColor = col.col6
        case 6:
            cell.backgroundColor = col.col7
        case 7:
            cell.backgroundColor = col.col8
        case 8:
            cell.backgroundColor = col.col9
        case 9:
            cell.backgroundColor = col.col10
        case 10:
            cell.backgroundColor = col.col11
        case 11:
            cell.backgroundColor = col.col12
        case 12:
            cell.backgroundColor = col.col13
        case 13:
            cell.backgroundColor = col.col14
        case 14:
            cell.backgroundColor = col.col15
        case 15:
            cell.backgroundColor = col.col16
        case 16:
            cell.backgroundColor = col.col17
        case 17:
            cell.backgroundColor = col.col18
        case 18:
            cell.backgroundColor = col.col19
        case 19:
            cell.backgroundColor = col.col20
        case 20:
            cell.backgroundColor = col.col21
        case 21:
            cell.backgroundColor = col.col22
        case 22:
            cell.backgroundColor = col.col23
        case 23:
            cell.backgroundColor = col.col24
        default:
            cell.backgroundColor = UIColor.white
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(getType)
        print(indexPath.row)
        print("-----------")
        
        _ = FMDBDatabaseModel.getInstanceColorType().updateColor(type: getType, color: indexPath.row)
        
        
    }

}
