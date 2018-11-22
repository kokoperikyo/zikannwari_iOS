//
//  colorViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/08/05.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit

class colorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBAction func unwindActionFromColor(segue: UIStoryboardSegue) {
//        tblVIew.reloadData()
    }
    
    
    @IBOutlet weak var tblVIew: UITableView!
    
    @IBOutlet weak var backView: UIView!
    
    var gakka:Int = Int()
    
    //選択できる色の一覧
    var col = colorList()
    
    //タイプのリスト、学科のよって変わる
    var typeList:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        gakka = UserDefaults.standard.integer(forKey: "gakkaNum")
        
        if gakka == 1 || gakka == 2{
            typeList = ["言語","数理","一般教養","１群","２群","３群","４群","５群","６群","自由単位"]
        }else if gakka == 3{
            typeList = ["言語","数理","一般教養","１群","２群","３群-A","３群-B","４群","５群","６群","自由単位"]
        }else if gakka == 4{
            typeList = ["言語","数理","一般教養","経営学科の授業","経済学科の授業","国際学科の授業","自由単位"]
        }else if gakka == 5{
            typeList = ["基幹教養","一般教養（人文）","一般教養（社会）","一般教養（自然）","情報・統計科目群(必修)","情報・統計科目群(選択)","専門導入A","専門導入B","所属専門基礎科目群","専門基礎科目群（その他）","所属専門発展科目群","専門発展科目群（その他）","英語・日本語","専門導入A　（初年次ゼミ）","演　習・卒業論文","自由単位"]
        }
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tblVIew.reloadData()
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell") as! colorTableViewCell
        

        // cellの高さ、リストの数で割ることで画面いっぱいに広がる
        tableView.rowHeight = backView.bounds.height / CGFloat(typeList.count)
        
        
        cell.labType.text = "" + typeList[indexPath.row] + "     "
        
        var l = db_colorType()
        l = FMDBDatabaseModel.getInstanceColorType().GetDataOfColorTyoe(indexPath.row + 1).object(at: 0) as! db_colorType
        
        cell.viewColor.backgroundColor = colorList().targetColor(l.color)

                
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DV = MainStoryboard.instantiateViewController(withIdentifier: "selectColorViewController") as! selectColorViewController
        
        DV.getType = indexPath.row + 1
        
        
        self.navigationController?.pushViewController(DV, animated: true)
    }

    
    
    
    
    
    

}
