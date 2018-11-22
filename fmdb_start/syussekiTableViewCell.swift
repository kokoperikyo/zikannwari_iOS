//
//  syussekiTableViewCell.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/10/03.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class syussekiTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labsyukketu: UILabel!
    @IBOutlet weak var labWhen: UILabel!
    
    @IBOutlet weak var plusMinusImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
