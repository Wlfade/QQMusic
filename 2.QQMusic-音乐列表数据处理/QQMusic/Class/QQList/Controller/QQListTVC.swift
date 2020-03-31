//
//  QQListTVC.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQListTVC: UITableViewController {

    var musicMs : [QQMusicModel] = [QQMusicModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //界面处理
        setUpInit()
        
        QQMusicDataTool.getMusicMs { (modles : [QQMusicModel]) in
            print(modles)
            self.musicMs = modles
        }
    }
}
 
// MARK: - Table view data source
extension QQListTVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return musicMs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = QQMusicCell.cellWithTableView(tableView: tableView)
        
        //取出数据模型 给cell 赋值
        let model = musicMs[indexPath.row]
        
        cell.musicModel = model
        

        
        cell.addAnimation(type: .translation)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modle = musicMs[indexPath.row];
        
        print("播放音乐--"+modle.name!)
        
        QQMusicOperationTool.shareInstance.playMusic(musicM: modle)
        
//        self.performSegue(withIdentifier: "listToDetail", sender: nil)
    
//        self.performSegue(withIdentifier: "push", sender: nil)

        self.navigationController?.performSegue(withIdentifier: "push", sender: nil)
    }
}

//MARK:- 界面处理
extension QQListTVC{
    
    //界面处理的总入口
    func setUpInit() -> () {
        setTableView()
    }
    
    func setTableView() -> () {
        let imageView = UIImageView(image: UIImage(named: "QQListBack.jpg"))
        tableView.backgroundView = imageView
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
    }
    
    
}

//MARK:- 状态栏处理
extension QQListTVC {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return UIStatusBarStyle.lightContent
        
    }
}

