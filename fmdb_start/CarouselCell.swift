//
//  CarouselCell.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/29.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    

    var img:UIImageView!
    var backButton:UIButton!
    var backImg:UIImageView!
    
    var testlab:UILabel!
    
    
    // ここでセットアップする
    func setup() {
        
        
        // セルの縦横を取得する
        let width:CGFloat = self.contentView.frame.width
        let height:CGFloat = self.contentView.frame.height
        

        
        
        //背景画像を周りにセット
        backImg = UIImageView()
        backImg.frame = CGRect(x:frame.width * -0.075,y:frame.height * -0.04,width:width * 1.15,height:height * 1.08)
        
        backImg.layer.cornerRadius = 30
        backImg.clipsToBounds = true

        
        //スマホの画像をセット
        img = UIImageView()
        img.frame = CGRect(x:0,y:0,width:width,height:height)
        
        //押された時の処理を書くために
        backButton = UIButton()
        backButton.frame = CGRect(x:0,y:0,width:width,height:height)

        
        

        self.contentView.addSubview(backImg)
        self.contentView.addSubview(img)
        self.contentView.addSubview(backButton)

        
        
        
        
        // セルを角丸にする
        self.contentView.layer.cornerRadius = 10
        
        //かげ
        self.contentView.layer.shadowOffset = CGSize(width: 10,height: 10) // 影の位置
        self.contentView.layer.shadowColor = #colorLiteral(red: 0.2138669491, green: 0.2122896314, blue: 0.2150782347, alpha: 1)       // 影の色
        self.contentView.layer.shadowOpacity = 1                       // 影の透明度
        self.contentView.layer.shadowRadius = 10                        // 影の広がり
    }
    

    
}

