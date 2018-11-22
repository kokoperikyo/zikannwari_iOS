//
//  allLecTableViewCell.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/21.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit


//このcellとtabelviewをつなげるprotocol
protocol allbuttonDelegate {
    func allRegButton(sender:allLecTableViewCell)
    func allShiraButton(sender:allLecTableViewCell)
}

class allLecTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var labLec: UILabel!
    @IBOutlet weak var labRoom: UILabel!
    @IBOutlet weak var labTea: UILabel!
    @IBOutlet weak var komaName: UILabel!
    @IBOutlet weak var zennkiOrKouki: UILabel!
    
    @IBOutlet weak var imgRoom: UIImageView!
    @IBOutlet weak var imgTeacher: UIImageView!
    
    @IBOutlet weak var regButton: UIButton!
    @IBOutlet weak var shiraButton: UIButton!
    
    
    var zennkiOrKoukiNum = Int()
    
    
    //ボタン押した時の処理で使う変数の定義
    var allReg:allbuttonDelegate?
    var allShira:allbuttonDelegate?
    
    //タイプを代入する
    var typeNum:Int = Int()
    var shiraPage:Int = Int()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func regTapped(_ sender: Any) {
        self.allReg?.allRegButton(sender: self)
    }
    
    @IBAction func shiraTapped(_ sender: Any) {
        self.allShira?.allShiraButton(sender: self)
    }
    
}
