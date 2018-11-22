//
//  syussekiViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/10/03.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class syussekiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var getkomaNum = Int()
    
    var GetDataOfSyukketu = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GetDataOfSyukketu = FMDBDatabaseModel.getInstanceSyusseki().getsyukketuHis(komaNum: getkomaNum)
        
        

       
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetDataOfSyukketu.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "syussekiCell") as! syussekiTableViewCell
        
        
        tableView.rowHeight = 60
        
        var l = db_syusseki()
        l = GetDataOfSyukketu.object(at: indexPath.row) as! db_syusseki
        
        cell.labWhen.text = l.When
        
        setCellInfo(cell: cell, syukketuNum: l.syukketuNum)

        
        
        return cell
        
        
    }
    
    func setCellInfo(cell:syussekiTableViewCell,syukketuNum:Int){
        if syukketuNum < 4{
            cell.plusMinusImg.image = UIImage(named: "minus1")
        }else{
            cell.plusMinusImg.image = UIImage(named: "plus1")
        }
        
        switch syukketuNum {
        case 1:
            cell.labsyukketu.text = "出席取り消し"
        case 2:
            cell.labsyukketu.text = "遅刻取り消し"
        case 3:
            cell.labsyukketu.text = "欠席取り消し"
        case 4:
            cell.labsyukketu.text = "出席"
        case 5:
            cell.labsyukketu.text = "遅刻"
        case 6:
            cell.labsyukketu.text = "欠席"


        default:
            true
        }
        
    }


}
