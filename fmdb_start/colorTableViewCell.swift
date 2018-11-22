//
//  colorTableViewCell.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/05.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class colorTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var labType: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
