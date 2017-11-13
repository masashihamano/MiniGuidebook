//
//  ViewController.swift
//  sampleMiniGuidebook
//
//  Created by 濱野将士 on 2017/11/09.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

//1プロトコルの設定
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    //選択されたエリア名を保存するメンバ変数
    var selectedName = ""
    
    var areaList:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

            //ファイルパスを取得(エリア名が格納されているプロパティリスト)
            let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
            //ファイルの内容を読み込んでディクショナリー型に格納
            let dic = NSDictionary(contentsOfFile: filePath!)
        
            //TableViewで扱いやすい配列の形(エリア名の入ってる配列)を作成
            for (key,date) in dic! {
                print(key)
                areaList.append(key as! String)
            }
        
        
        
        
    }
    
    //4.TableViewに指示を出すのがViewControllerだと設定する
    // myTableView.delegate = self プログラムで書く場合
    // myTableView.dataSource = self プログラムで書く場合
    
    
    //5.tableViewにCellオブジェクトを追加してidentifierに「Cell」という名前をつける → 終了
    
    
//2行数の決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }

    //3表示する文字列を決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        //文字列を表示するセルの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"
            , for: indexPath)
        
        //表示したい文字の設定
        cell.textLabel?.text = areaList[indexPath.row]
        
        //文字色を紫色にする
        cell.textLabel?.textColor = UIColor.purple
        //矢印を右側につける
        cell.accessoryType = .disclosureIndicator
        
        
        //文字を設定したセルを返す
        cell.textLabel!.text = areaList[(indexPath as NSIndexPath).row] as String
        return cell
    }
    
    //セルがタップされたとき
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            //タップされた行のエリア名を保存
            selectedName = areaList[(indexPath.row)]
            
            //セグエのidentifierを指定して、画面移動
            performSegue(withIdentifier: "showDetail",sender: nil)
    }
    
    // Segueで画面遷移する時
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            //次の画面のインスタンスを取得
            var dvc = segue.destination as! DetailViewController
            
            //次の画面のプロパティにタップされた行のエリア名を渡す
            dvc.getAreaName = selectedName
            
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 選択された時に行う処理
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\((indexPath as NSIndexPath).row)行目を選択")
//        selectedName = guideList[(indexPath as NSIndexPath).row] as String
//        performSegue(withIdentifier: "showSecondView",sender: nil)
//    }
    
    

}

