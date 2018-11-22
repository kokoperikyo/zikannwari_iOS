//
//  shirabasuViewController.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/20.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import UIKit
import PDFKit

class shirabasuViewController: UIViewController {
    
    var getPage:Int = Int()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //紐付け
        let pdfView = PDFView(frame: view.frame)
        
        //pdfの指定
        let pdfURL = URL(fileURLWithPath: Bundle.main.path(forResource: "shirabasu_kouki_com_test_", ofType: "pdf")!)
        
        //pdfViewと読み込んだpdfがつながる
        let document = PDFDocument(url: pdfURL)
        document?.exchangePage(at: 0, withPageAt: getPage)
        pdfView.document = document
        
        
        
        
        //背景色の設定
        pdfView.backgroundColor = .lightGray
        // PDFの拡大率を調整する
        pdfView.autoScales = true
        // 表示モード
        pdfView.displayMode = .singlePage
        
        //pdfの中心位置の設定的な、これが一番いい感じ
        pdfView.displayBox = .cropBox
        
        
        //pdfの表示
        view.addSubview(pdfView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
