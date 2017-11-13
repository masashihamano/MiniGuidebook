//
//  DetailViewController.swift
//  sampleMiniGuidebook
//
//  Created by 濱野将士 on 2017/11/10.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myMap: MKMapView!
    
    //前の画面から受け取るためのプロパティ
    var getAreaName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("getAreaName:\(getAreaName)")
        
    //ファイルパスを取得(エリア名が格納されているプロパティリスト)
    let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
    
    //ファイルの内容を読み込んでディクショナリー型に格納
    let dic = NSDictionary(contentsOfFile: filePath!)
    
    //今画面に表示したいデータの取得
    let detailInfo = dic![getAreaName] as! NSDictionary
    
    //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
    print(detailInfo["description"] as! String)
    print(detailInfo["image"] as! String)
    print(detailInfo["latitude"] as! String)
    print(detailInfo["longitude"] as! String)
    
    //タイトル
//    areaTitle.text = getAreaName
        
    //タイトルをナビゲーションバーの真ん中に表示
    navigationItem.title = getAreaName
//   これでもOK↓
//   self.title = getAreaName
        
        
    //説明
    myTextView.text = detailInfo["description"] as! String
    
    //画像
    myImageView.image = UIImage(named:detailInfo["image"] as! String)
        
    //地図
        let latitude = detailInfo["latitude"] as! String
        let longitude = detailInfo["longitude"] as! String
    
    //座標オブジェクト
    //型変換　String型→Double型
        let coodinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
        
        
    //拡縮率
        let span = MKCoordinateSpanMake(0.08, 0.08)
        
    //範囲オブジェクト
        let region = MKCoordinateRegionMake(coodinate, span)
        
    //地図にセット
        myMap.setRegion(region, animated: true)
        
        
    //ピンを作成
        let mypin:MKPointAnnotation = MKPointAnnotation()
    // 座標を設定.
        mypin.coordinate = coodinate
    // タイトルを設定.
        mypin.title = getAreaName
    // MapViewにピンを追加.
        myMap.addAnnotation(mypin)
        
        
    
        
    //TableViewで扱いやすい配列の形(エリア名の入ってる配列)を作成
//    for (key,date) in dic! {
//    print(key)
//    areaList.append(key as! String)
//    }
    

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
