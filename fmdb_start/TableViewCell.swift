//
//  TableViewCell.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/16.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit
protocol buttonDelegate {
    func shiraButton(sender:TableViewCell)
}


class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labLec: UILabel!
    @IBOutlet weak var labRoom: UILabel!
    @IBOutlet weak var labTeacher: UILabel!
    @IBOutlet weak var labShira: UILabel!
    @IBOutlet weak var btnShira: UIButton!
    
    @IBOutlet weak var imgRoom: UIImageView!
    @IBOutlet weak var imgTeacher: UIImageView!
    @IBOutlet weak var imgShira: UIImageView!
    
    
    
    var shira:buttonDelegate?
    
    var shiraPage:Int = Int()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


    
    @IBAction func shiraTapped(_ sender: Any) {
        self.shira?.shiraButton(sender: self)
    }
    
    
}
