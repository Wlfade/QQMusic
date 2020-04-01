//
//  QQMusicDataTool.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQMusicDataTool: NSObject {
    class func getMusicMs(result :([QQMusicModel])->()){
        //解析歌曲信息
        
        //1.获取文件路径
         guard let path = Bundle.main.path(forResource: "Musics.plist", ofType: nil) else {
            result([QQMusicModel]())
            return
        }
        //2.读取文件内容
        guard let array = NSArray(contentsOfFile: path) else {
            result([QQMusicModel]())
            return
        }
        //3.解析：转换成歌曲模型
        var models = [QQMusicModel]()
        for dic in array {
            let model = QQMusicModel(dic: dic as! [String : AnyObject])
            models.append(model)
            
        }
        //4.返回结果
        result(models);
        
    }
}
