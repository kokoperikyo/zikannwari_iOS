//
//  FMDBDatabaseModel.swift
//  fmdb_start
//
//  Created by 山本シェーン on 2018/07/10.
//  Copyright © 2018年 山本シェーン. All rights reserved.
//

import Foundation
import UIKit


let sharedInstance = FMDBDatabaseModel()
class FMDBDatabaseModel: NSObject {
    
    // UserDefaultsを使ってフラグを保持する
    let userDefault = UserDefaults.standard
    
    var seleGakka:Int = Int()
    var zennkiOrKouki:Int = Int()
    var NowZikannNum:Int = Int()
    
    var databese:FMDatabase? = nil
    
    //Zikann_RegLec
    class func getInstanceRegLec() -> FMDBDatabaseModel
    {
//        if (sharedInstance.databese == nil)
//        {
            sharedInstance.databese = FMDatabase(path: Util.getPath(fileName: "Zikann_RegLec12.sqlite"))
//        }
        return sharedInstance
        
    }
    
    
    //Zikann_ColorType
    class func getInstanceColorType() -> FMDBDatabaseModel
    {
//        if (sharedInstance.databese == nil)
//        {
            sharedInstance.databese = FMDatabase(path: Util.getPath(fileName: "Zikann_ColorType9.sqlite"))
//        }
        return sharedInstance
        
    }
    
    //Zikann_UmeKeizai
    class func getInstanceUmeKeizai() -> FMDBDatabaseModel
    {
//        if (sharedInstance.databese == nil)
//        {
            sharedInstance.databese = FMDatabase(path: Util.getPath(fileName: "Zikann_UmeKeizai2.sqlite"))
//        }
        return sharedInstance
        
    }
    
    //Zikann_Koma
    class func getInstanceKoma() -> FMDBDatabaseModel
    {
//        if (sharedInstance.databese == nil)
//        {
            sharedInstance.databese = FMDatabase(path: Util.getPath(fileName: "Zikann_Koma9.sqlite"))
//        }
        return sharedInstance
        
    }
    
    //Zikann_ZikannName
    class func getInstanceZikannName() -> FMDBDatabaseModel
    {
        //        if (sharedInstance.databese == nil)
        //        {
        sharedInstance.databese = FMDatabase(path: Util.getPath(fileName: "Zikann_SaveName4.sqlite"))
        //        }
        return sharedInstance
        
    }
    
    //syusseki
    class func getInstanceSyusseki() -> FMDBDatabaseModel
    {
        //        if (sharedInstance.databese == nil)
        //        {
        sharedInstance.databese = FMDatabase(path: Util.getPath(fileName: "syusseki2.sqlite"))
        //        }
        return sharedInstance
        
    }
    
    
    //コマの情報を取得
    func GetAllDataOfKoma() -> NSMutableArray {
        sharedInstance.databese!.open()
        
        NowZikannNum = userDefault.integer(forKey: "zikannNum")

 
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM koma WHERE zikannNum = \(NowZikannNum)", withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_koma = db_koma()
                item.lecture = String(resultSet.string(forColumn: "lecture")!)
                item.room = String(resultSet.string(forColumn: "room")!)
                item.teacher = String(resultSet.string(forColumn: "teacher")!)
                item.comment = String(resultSet.string(forColumn: "comment")!)
                item.komaNum = Int(resultSet.int(forColumn: "komaNum"))
                item.type = Int(resultSet.int(forColumn: "type"))
                item.syussekiCount = Int(resultSet.int(forColumn: "syussekiCount"))
                item.tikokuCount = Int(resultSet.int(forColumn: "tikokuCount"))
                item.kessekiCount = Int(resultSet.int(forColumn: "kessekiCount"))
                
                
                itemInfo.add(item)
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    //タイプ別の色を取得
    func GetDataOfColorTyoe(_ seleType:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM colorType WHERE gakka = \(seleGakka) AND type = \(seleType)" , withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                let item:db_colorType = db_colorType()
                item.color = Int(resultSet.int(forColumn: "color"))
                
                itemInfo.add(item)
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    
    
    func GetDataOfLec(_ seleKoma:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        zennkiOrKouki = userDefault.integer(forKey: "zennkiOrKouki")
        
        
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND zennkiOrKouki = \(zennkiOrKouki) AND tappedKoma = \(seleKoma) ORDER BY type,lecture ASC", withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                item.type = Int(resultSet.int(forColumn: "type"))
                item.shira = Int(resultSet.int(forColumn: "shiraPage"))
                item.zennkiOrKouki = Int(resultSet.int(forColumn: "zennkiOrKouki"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    func GetDataOfLecAll(_ seleKoma:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        
        
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND  tappedKoma = \(seleKoma) ORDER BY type,lecture ASC", withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                item.type = Int(resultSet.int(forColumn: "type"))
                item.shira = Int(resultSet.int(forColumn: "shiraPage"))
                item.zennkiOrKouki = Int(resultSet.int(forColumn: "zennkiOrKouki"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    func GetDataOfLecByLec(_ seleLec:Array<Any>) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        

        
        for i in 0..<seleLec.count{
            let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND lecture IN ('\(seleLec[i])') ORDER BY type,lecture ASC", withArgumentsIn: [0])
            
            
            
            
            if (resultSet != nil)
            {
                while resultSet.next() {
                    
                    //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                    let item:db_regLec = db_regLec()
                    item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                    item.regRoom = String(resultSet.string(forColumn: "room")!)
                    item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                    item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                    item.type = Int(resultSet.int(forColumn: "type"))
                    item.shira = Int(resultSet.int(forColumn: "shiraPage"))
                    item.zennkiOrKouki = Int(resultSet.int(forColumn: "zennkiOrKouki"))
                    
                    
                    itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
                    
                    
                    
                }
                
            }
        }
        

        
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    func GetDataOfLecByType(_ seleType:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND type = \(seleType) ORDER BY type,lecture ASC", withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                item.type = Int(resultSet.int(forColumn: "type"))
                item.shira = Int(resultSet.int(forColumn: "shiraPage"))
                item.zennkiOrKouki = Int(resultSet.int(forColumn: "zennkiOrKouki"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    func GetDataOfKisoSonotaLecByType(_ num1:Int,_ num2:Int,_ num3:Int) -> NSMutableArray {
        sharedInstance.databese!.open()

        seleGakka = userDefault.integer(forKey: "gakkaNum")


        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND (type = \(num1) OR type = \(num2) OR type = \(num3)) ORDER BY type,lecture ASC", withArgumentsIn: [0])

        let itemInfo:NSMutableArray = NSMutableArray()
        if (resultSet != nil)
        {
            while resultSet.next() {

                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                item.type = Int(resultSet.int(forColumn: "type"))
                item.shira = Int(resultSet.int(forColumn: "shiraPage"))
                item.zennkiOrKouki = Int(resultSet.int(forColumn: "zennkiOrKouki"))

                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }

        }

        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }

    
    
    func GetALLDataOfLec() -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) ORDER BY type,lecture ASC", withArgumentsIn: [0])
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                item.type = Int(resultSet.int(forColumn: "type"))
                item.shira = Int(resultSet.int(forColumn: "shiraPage"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    func GetLecOfUme() -> NSMutableArray {
        sharedInstance.databese!.open()
        
        //全件取得なのでFROMとかは一切いらない
        //とにかくresultSetには全てが入っている
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM umeKeizai", withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {

                let item:db_umekeizai = db_umekeizai()
                item.id = Int(resultSet.int(forColumn: "id"))
                item.umeLec = String(resultSet.string(forColumn: "lecture")!)
                itemInfo.add(item)//要素数の配列がデータベースの行の数だけ作られる
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    
    //埋め卒に入れるためのリストを表示、その際にタイプで絞るのと梅卒にすでに埋まっている講義は排除する
    //通常モード
    func GetDataOfLecByTypeForUme(_ seleType:Int,_ umeNUm:Int,_ seleLec:Array<Any>) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
 
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        
        
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND type = \(seleType) AND NOT (lecture IN ('\(seleLec[umeNUm + 1])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 2])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 3])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 4])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 5])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 6])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 7])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 8])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 9])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 10])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 11])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 12])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 13])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 14])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 15])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 16])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 17])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 18])'))  AND NOT (lecture IN ('\(seleLec[umeNUm + 19])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 20])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 21])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 22])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 23])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 24])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 25])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 26])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 27])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 28])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 29])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 30])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 31])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 32])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 33])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 34])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 35])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 36])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 37])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 38])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 39])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 40])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 41])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 42])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 43])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 44])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 45])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 46])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 47])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 48])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 49])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 50])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 51])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 52])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 53])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 54])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 55])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 56])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 57])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 58])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 59])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 60])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 61])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 62])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 63])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 64])')) AND NOT (lecture IN ('\(seleLec[umeNUm + 65])')) ORDER BY lecture ASC", withArgumentsIn: [0])
        
            
            
            if (resultSet != nil)
            {
                while resultSet.next() {
                    
                    //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                    let item:db_regLec = db_regLec()
                    item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                    item.regRoom = String(resultSet.string(forColumn: "room")!)
                    item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                    item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                    
                    itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
                }
                
            }
        
        
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    //埋め卒に入れるためのリストを表示、その際にタイプで絞るのと梅卒にすでに埋まっている講義は排除する
    //１〜５群
    func GetDataOfLecByTypeForUme100(_ seleLec:Array<Any>) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND (type = 4 OR type = 5 OR type = 6 OR type = 7 OR type = 8) AND NOT (lecture IN ('\(seleLec[15])')) AND NOT (lecture IN ('\(seleLec[16])')) AND NOT (lecture IN ('\(seleLec[17])')) AND NOT (lecture IN ('\(seleLec[18])')) AND NOT (lecture IN ('\(seleLec[19])')) AND NOT (lecture IN ('\(seleLec[20])')) AND NOT (lecture IN ('\(seleLec[21])')) AND NOT (lecture IN ('\(seleLec[22])')) AND NOT (lecture IN ('\(seleLec[23])')) AND NOT (lecture IN ('\(seleLec[24])')) AND NOT (lecture IN ('\(seleLec[25])')) AND NOT (lecture IN ('\(seleLec[26])')) AND NOT (lecture IN ('\(seleLec[27])')) AND NOT (lecture IN ('\(seleLec[28])')) AND NOT (lecture IN ('\(seleLec[29])')) AND NOT (lecture IN ('\(seleLec[30])')) AND NOT (lecture IN ('\(seleLec[31])')) AND NOT (lecture IN ('\(seleLec[32])')) AND NOT (lecture IN ('\(seleLec[33])')) AND NOT (lecture IN ('\(seleLec[34])')) AND NOT (lecture IN ('\(seleLec[35])')) AND NOT (lecture IN ('\(seleLec[36])')) AND NOT (lecture IN ('\(seleLec[37])')) AND NOT (lecture IN ('\(seleLec[38])')) AND NOT (lecture IN ('\(seleLec[39])')) AND NOT (lecture IN ('\(seleLec[40])')) AND NOT (lecture IN ('\(seleLec[41])')) AND NOT (lecture IN ('\(seleLec[42])')) AND NOT (lecture IN ('\(seleLec[43])')) AND NOT (lecture IN ('\(seleLec[44])')) AND NOT (lecture IN ('\(seleLec[45])')) AND NOT (lecture IN ('\(seleLec[46])')) AND NOT (lecture IN ('\(seleLec[47])')) AND NOT (lecture IN ('\(seleLec[48])')) AND NOT (lecture IN ('\(seleLec[49])')) AND NOT (lecture IN ('\(seleLec[50])')) AND NOT (lecture IN ('\(seleLec[51])')) AND NOT (lecture IN ('\(seleLec[52])')) AND NOT (lecture IN ('\(seleLec[53])')) AND NOT (lecture IN ('\(seleLec[54])')) AND NOT (lecture IN ('\(seleLec[55])')) AND NOT (lecture IN ('\(seleLec[56])')) AND NOT (lecture IN ('\(seleLec[57])')) AND NOT (lecture IN ('\(seleLec[58])')) AND NOT (lecture IN ('\(seleLec[59])')) ORDER BY type,lecture ASC", withArgumentsIn: [0])
        
        
        
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }
            
        }


        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    //埋め卒に入れるためのリストを表示、その際にタイプで絞るのと梅卒にすでに埋まっている講義は排除する
    //国際の４群と５群
    func GetDataOfLecByTypeForUmekokusai(_ seleLec:Array<Any>) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND (type = 8 OR type = 9) AND NOT (lecture IN ('\(seleLec[36])')) AND NOT (lecture IN ('\(seleLec[37])')) AND NOT (lecture IN ('\(seleLec[38])')) AND NOT (lecture IN ('\(seleLec[39])')) AND NOT (lecture IN ('\(seleLec[40])')) AND NOT (lecture IN ('\(seleLec[41])')) AND NOT (lecture IN ('\(seleLec[42])')) AND NOT (lecture IN ('\(seleLec[43])')) AND NOT (lecture IN ('\(seleLec[44])')) AND NOT (lecture IN ('\(seleLec[45])')) AND NOT (lecture IN ('\(seleLec[46])')) AND NOT (lecture IN ('\(seleLec[47])')) AND NOT (lecture IN ('\(seleLec[48])')) AND NOT (lecture IN ('\(seleLec[49])')) AND NOT (lecture IN ('\(seleLec[50])')) AND NOT (lecture IN ('\(seleLec[51])')) AND NOT (lecture IN ('\(seleLec[52])')) AND NOT (lecture IN ('\(seleLec[53])')) AND NOT (lecture IN ('\(seleLec[54])')) AND NOT (lecture IN ('\(seleLec[55])')) AND NOT (lecture IN ('\(seleLec[56])')) AND NOT (lecture IN ('\(seleLec[57])')) AND NOT (lecture IN ('\(seleLec[58])')) AND NOT (lecture IN ('\(seleLec[59])')) ORDER BY type,lecture ASC", withArgumentsIn: [0])
        
        
        
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }
            
        }
        
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    //埋め卒に入れるためのリストを表示、その際にタイプで絞るのと梅卒にすでに埋まっている講義は排除する
    //２〜５群
    func GetDataOfLecByTypeForUme200(_ seleSennkou:Int,_ seleLec:Array<Any>) -> NSMutableArray {
        sharedInstance.databese!.open()

        
        seleGakka = userDefault.integer(forKey: "gakkaNum")
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND type = \(seleSennkou) AND NOT (lecture IN ('\(seleLec[18])')) AND NOT (lecture IN ('\(seleLec[19])')) AND NOT (lecture IN ('\(seleLec[20])')) AND NOT (lecture IN ('\(seleLec[21])')) AND NOT (lecture IN ('\(seleLec[22])')) AND NOT (lecture IN ('\(seleLec[23])')) AND NOT (lecture IN ('\(seleLec[24])')) AND NOT (lecture IN ('\(seleLec[25])')) AND NOT (lecture IN ('\(seleLec[26])')) AND NOT (lecture IN ('\(seleLec[27])')) AND NOT (lecture IN ('\(seleLec[28])')) AND NOT (lecture IN ('\(seleLec[29])')) AND NOT (lecture IN ('\(seleLec[30])')) AND NOT (lecture IN ('\(seleLec[31])')) AND NOT (lecture IN ('\(seleLec[32])')) AND NOT (lecture IN ('\(seleLec[33])')) AND NOT (lecture IN ('\(seleLec[34])')) AND NOT (lecture IN ('\(seleLec[35])')) AND NOT (lecture IN ('\(seleLec[36])')) AND NOT (lecture IN ('\(seleLec[37])')) AND NOT (lecture IN ('\(seleLec[38])')) AND NOT (lecture IN ('\(seleLec[39])')) AND NOT (lecture IN ('\(seleLec[40])')) AND NOT (lecture IN ('\(seleLec[41])')) AND NOT (lecture IN ('\(seleLec[42])')) AND NOT (lecture IN ('\(seleLec[43])')) AND NOT (lecture IN ('\(seleLec[44])')) AND NOT (lecture IN ('\(seleLec[45])')) AND NOT (lecture IN ('\(seleLec[46])')) AND NOT (lecture IN ('\(seleLec[47])')) AND NOT (lecture IN ('\(seleLec[48])')) AND NOT (lecture IN ('\(seleLec[49])')) AND NOT (lecture IN ('\(seleLec[50])')) AND NOT (lecture IN ('\(seleLec[51])')) AND NOT (lecture IN ('\(seleLec[52])')) AND NOT (lecture IN ('\(seleLec[53])')) AND NOT (lecture IN ('\(seleLec[54])')) AND NOT (lecture IN ('\(seleLec[55])')) AND NOT (lecture IN ('\(seleLec[56])')) AND NOT (lecture IN ('\(seleLec[57])')) AND NOT (lecture IN ('\(seleLec[58])')) AND NOT (lecture IN ('\(seleLec[59])')) ORDER BY lecture ASC", withArgumentsIn: [0])
        
        
        
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }
            
        }
        
        
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    //埋め卒に入れるためのリストを表示、その際にタイプで絞るのと梅卒にすでに埋まっている講義は排除する
    //自由単位
    func GetDataOfLecByTypeForUmeZiyuu(_ seleLec:Array<Any>) -> NSMutableArray {
        sharedInstance.databese!.open()


        seleGakka = userDefault.integer(forKey: "gakkaNum")
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()

        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM regLec WHERE gakka = \(seleGakka) AND NOT (lecture IN ('\(seleLec[0])')) AND NOT (lecture IN ('\(seleLec[1])')) AND NOT (lecture IN ('\(seleLec[2])')) AND NOT (lecture IN ('\(seleLec[3])')) AND NOT (lecture IN ('\(seleLec[4])')) AND NOT (lecture IN ('\(seleLec[5])')) AND NOT (lecture IN ('\(seleLec[6])')) AND NOT (lecture IN ('\(seleLec[7])')) AND NOT (lecture IN ('\(seleLec[8])')) AND NOT (lecture IN ('\(seleLec[9])')) AND NOT (lecture IN ('\(seleLec[10])')) AND NOT (lecture IN ('\(seleLec[11])')) AND NOT (lecture IN ('\(seleLec[12])')) AND NOT (lecture IN ('\(seleLec[13])')) AND NOT (lecture IN ('\(seleLec[14])')) AND NOT (lecture IN ('\(seleLec[15])')) AND NOT (lecture IN ('\(seleLec[16])')) AND NOT (lecture IN ('\(seleLec[17])')) AND NOT (lecture IN ('\(seleLec[18])')) AND NOT (lecture IN ('\(seleLec[19])')) AND NOT (lecture IN ('\(seleLec[20])')) AND NOT (lecture IN ('\(seleLec[21])')) AND NOT (lecture IN ('\(seleLec[22])')) AND NOT (lecture IN ('\(seleLec[23])')) AND NOT (lecture IN ('\(seleLec[24])')) AND NOT (lecture IN ('\(seleLec[25])')) AND NOT (lecture IN ('\(seleLec[26])')) AND NOT (lecture IN ('\(seleLec[27])')) AND NOT (lecture IN ('\(seleLec[28])')) AND NOT (lecture IN ('\(seleLec[29])')) AND NOT (lecture IN ('\(seleLec[30])')) AND NOT (lecture IN ('\(seleLec[31])')) AND NOT (lecture IN ('\(seleLec[32])')) AND NOT (lecture IN ('\(seleLec[33])')) AND NOT (lecture IN ('\(seleLec[34])')) AND NOT (lecture IN ('\(seleLec[35])')) AND NOT (lecture IN ('\(seleLec[36])')) AND NOT (lecture IN ('\(seleLec[37])')) AND NOT (lecture IN ('\(seleLec[38])')) AND NOT (lecture IN ('\(seleLec[39])')) AND NOT (lecture IN ('\(seleLec[40])')) AND NOT (lecture IN ('\(seleLec[41])')) AND NOT (lecture IN ('\(seleLec[42])')) AND NOT (lecture IN ('\(seleLec[43])')) AND NOT (lecture IN ('\(seleLec[44])')) AND NOT (lecture IN ('\(seleLec[45])')) AND NOT (lecture IN ('\(seleLec[46])')) AND NOT (lecture IN ('\(seleLec[47])')) AND NOT (lecture IN ('\(seleLec[48])')) AND NOT (lecture IN ('\(seleLec[49])')) AND NOT (lecture IN ('\(seleLec[50])')) AND NOT (lecture IN ('\(seleLec[51])')) AND NOT (lecture IN ('\(seleLec[52])')) AND NOT (lecture IN ('\(seleLec[53])')) AND NOT (lecture IN ('\(seleLec[54])')) AND NOT (lecture IN ('\(seleLec[55])')) AND NOT (lecture IN ('\(seleLec[56])')) AND NOT (lecture IN ('\(seleLec[57])')) AND NOT (lecture IN ('\(seleLec[58])')) AND NOT (lecture IN ('\(seleLec[59])'))", withArgumentsIn: [0])



        if (resultSet != nil)
        {
            while resultSet.next() {

                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_regLec = db_regLec()
                item.regLecture = String(resultSet.string(forColumn: "lecture")!)
                item.regRoom = String(resultSet.string(forColumn: "room")!)
                item.regTeacher = String(resultSet.string(forColumn: "teacher")!)
                item.tappedKoma = Int(resultSet.int(forColumn: "tappedKoma"))

                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }

        }



        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    //記憶された時間割の情報、（全権取得）
    func GetAllDataOfZikannName() -> NSMutableArray {
        sharedInstance.databese!.open()

        
        //全件取得なのでFROMとかは一切いらない
        //とにかくresultSetには全てが入っている
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM saveName", withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_zikannName = db_zikannName()
                item.num = Int(resultSet.int(forColumn: "numOfZikann"))
                item.name = String(resultSet.string(forColumn: "nameOfZikann")!)
                
                itemInfo.add(item)
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    //記憶された時間割の情報、（現在の時間割で固定）
    func GetDataOfZikannName() -> NSMutableArray {
        sharedInstance.databese!.open()
        
        NowZikannNum = userDefault.integer(forKey: "zikannNum")
        
        //全件取得なのでFROMとかは一切いらない
        //とにかくresultSetには全てが入っている
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM saveName WHERE numOfZikann = \(NowZikannNum)", withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_zikannName = db_zikannName()
                item.num = Int(resultSet.int(forColumn: "numOfZikann"))
                item.name = String(resultSet.string(forColumn: "nameOfZikann")!)
                
                itemInfo.add(item)
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    //出席の履歴
    func getsyukketuHis(komaNum:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        
        //全件取得なのでFROMとかは一切いらない
        //とにかくresultSetには全てが入っている
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("SELECT * FROM history WHERE komaNum = \(komaNum)", withArgumentsIn: [0])
        
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_syusseki = db_syusseki()
                item.syukketuNum = Int(resultSet.int(forColumn: "whichButton"))
                item.When = String(resultSet.string(forColumn: "whenDate")!)
                
                itemInfo.add(item)
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        //返す
        return itemInfo
    }
    
    
    //lecTableViewから登録された時
    func setKoma(lecture:String,room:String,teacher:String,type:Int,tappedkoma:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        NowZikannNum = userDefault.integer(forKey: "zikannNum")
        
        //ここで渡ってきたidの行の編集（update）は完了だがexecuteQueryなので編集した最新情報がSELECTと同じ要領でresultSetに代入される
        //なのでこっからはSELECTと同じ要領
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("UPDATE koma SET lecture = ?,room = ?,teacher = ? ,type = ? WHERE komaNum = ? AND zikannNum = ?", withArgumentsIn: [lecture,room,teacher,type,tappedkoma,NowZikannNum])
        
        
        
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_koma = db_koma()
                item.lecture = String(resultSet.string(forColumn: "lecture")!)
                item.room = String(resultSet.string(forColumn: "room")!)
                item.comment = String(resultSet.string(forColumn: "comment")!)
                item.komaNum = Int(resultSet.int(forColumn: "komaNum"))
                item.type = Int(resultSet.int(forColumn: "type"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        return itemInfo
        
    }
    
    
    //DetailViewControllerのsaveボタンが押された時
    func updateKoma(lecture:String,room:String,comment:String,tappedkoma:Int,syussekiCount:Int,tikokuCount:Int,kessekiCount:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        NowZikannNum = userDefault.integer(forKey: "zikannNum")
        
        //ここで渡ってきたidの行の編集（update）は完了だがexecuteQueryなので編集した最新情報がSELECTと同じ要領でresultSetに代入される
        //なのでこっからはSELECTと同じ要領
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("UPDATE koma SET lecture = ?,room = ?,comment = ?,syussekiCount = ?,tikokuCount = ?,kessekiCount = ? WHERE komaNum = ? AND zikannNum = ?", withArgumentsIn: [lecture,room,comment,syussekiCount,tikokuCount,kessekiCount,tappedkoma,NowZikannNum])
        
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_koma = db_koma()
                item.lecture = String(resultSet.string(forColumn: "lecture")!)
                item.room = String(resultSet.string(forColumn: "room")!)
                item.comment = String(resultSet.string(forColumn: "comment")!)
                item.komaNum = Int(resultSet.int(forColumn: "komaNum"))
                item.syussekiCount = Int(resultSet.int(forColumn: "syussekiCount"))
                item.tikokuCount = Int(resultSet.int(forColumn: "tikokuCount"))
                item.kessekiCount = Int(resultSet.int(forColumn: "kessekiCount"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
            }
            
        }
        
        sharedInstance.databese!.close()
        return itemInfo
        
    }
    
    
    //削除
    func updateDeleteKoma(tappedkoma:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        NowZikannNum = userDefault.integer(forKey: "zikannNum")
        
        //ここで渡ってきたidの行の編集（update）は完了だがexecuteQueryなので編集した最新情報がSELECTと同じ要領でresultSetに代入される
        //なのでこっからはSELECTと同じ要領
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("UPDATE koma SET lecture = ?,room = ?,comment = ?,syussekiCount = ?,tikokuCount = ?,kessekiCount = ?,type = 0 WHERE komaNum = ? AND zikannNum = ?", withArgumentsIn: ["","","",0,0,0,tappedkoma,NowZikannNum])
        
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_koma = db_koma()
                item.lecture = String(resultSet.string(forColumn: "lecture")!)
                item.room = String(resultSet.string(forColumn: "room")!)
                item.comment = String(resultSet.string(forColumn: "comment")!)
                item.komaNum = Int(resultSet.int(forColumn: "komaNum"))
                item.syussekiCount = Int(resultSet.int(forColumn: "syussekiCount"))
                item.tikokuCount = Int(resultSet.int(forColumn: "tikokuCount"))
                item.kessekiCount = Int(resultSet.int(forColumn: "kessekiCount"))
                
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        return itemInfo
        
    }
    
    
    func umeUme(lecture:String,tappedNum:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        
        
        //ここで渡ってきたidの行の編集（update）は完了だがexecuteQueryなので編集した最新情報がSELECTと同じ要領でresultSetに代入される
        //なのでこっからはSELECTと同じ要領
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("UPDATE umeKeizai SET lecture = ? WHERE id = ?", withArgumentsIn: [lecture,tappedNum])
        
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_umekeizai = db_umekeizai()
                item.id = Int(resultSet.int(forColumn: "id"))
                item.umeLec = String(resultSet.string(forColumn: "lecture")!)
                itemInfo.add(item)//要素数４の配列がデータベースの行の数だけ作られる
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        return itemInfo
        
    }
    
    
    //色の設定、アップデート
    func updateColor(type:Int,color:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("UPDATE colorType SET color = \(color) WHERE gakka = \(seleGakka) AND type = \(type)", withArgumentsIn: [0])
        
        //配列かな？
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                //ここはTbl_Infoを使いことに意味はない。新しく変数を4つ作って代入してもいいいがめんどいのでTbl_Infoを使う
                let item:db_colorType = db_colorType()
                item.color = Int(resultSet.int(forColumn: "color"))
                
                itemInfo.add(item)
                
                
            }
            
        }
        
        sharedInstance.databese!.close()
        return itemInfo
        
    }
    
    
    //komaViewの時間割保存ボタンが押された時の処理
    func putZikannName(name:String){
        sharedInstance.databese!.open()
        
        NowZikannNum = userDefault.integer(forKey: "zikannNum")
        
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("UPDATE saveName SET nameOfZikann = '\(name)' WHERE numOfZikann = \(NowZikannNum)", withArgumentsIn: [0])
        
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                _ = String(resultSet.string(forColumn: "nameOfZikann")!)
                
            }
        }

        sharedInstance.databese!.close()


    }
    
    
    //出席状況の履歴
    func syussekiHistory(_ whichButton:Int,_ when:String,_ komaNum:Int) -> Bool {
        sharedInstance.databese!.open()
        let isInserted = sharedInstance.databese!.executeUpdate("INSERT INTO history(whichButton,whenDate,komaNum) VALUES(?,?,?)", withArgumentsIn: [whichButton,when,komaNum])

        
        sharedInstance.databese!.close()
        return (isInserted != nil)
        
    }
    
    //デリート、削除処理
    //出席履歴の削除
    func deleteSyussekiHis(komaNum:Int) -> NSMutableArray {
        sharedInstance.databese!.open()
        
        let resultSet:FMResultSet! = sharedInstance.databese!.executeQuery("DELETE FROM history WHERE komaNum = \(komaNum)", withArgumentsIn: [0])
        
        let itemInfo:NSMutableArray = NSMutableArray ()
        if (resultSet != nil)
        {
            while resultSet.next() {
                
                let item:db_syusseki = db_syusseki()
                item.syukketuNum = Int(resultSet.int(forColumn: "whichButton"))
                item.komaNum = Int(resultSet.int(forColumn: "komaNum"))
                item.When = String(resultSet.string(forColumn: "whenDate")!)
                itemInfo.add(item)
            }
        }
        
        sharedInstance.databese!.close()
        return itemInfo
        
    }
    
}

