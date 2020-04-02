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
    
    class func getLrcMs(lrcName:String?)->[QQLrcModel] {
        if lrcName == nil {
            return [QQLrcModel]()
        }
        //1. 获取文件的路径
        guard let path = Bundle.main.path(forResource: lrcName, ofType: nil) else {
            return [QQLrcModel]()
        }
        
        //2.读取文件的内容(字符串)
        var lrcContent = ""
        
        do {
            lrcContent = try String(contentsOfFile: path)
        } catch {
            print(error)
            return [QQLrcModel]()
        }
        
        //3.解析字符串（转换成为QQLrcModel 组成的数组）
        print(lrcContent)
        
        let timeContentArr = lrcContent.components(separatedBy: "\n")
        
        var resultMs = [QQLrcModel]()
        for timeContentStr in timeContentArr {
            if timeContentStr.contains("[ti:") ||
               timeContentStr.contains("[ar:") ||
               timeContentStr.contains("[al:") {
                continue
            }
            
            //获取真正的对的格式数据
            let resultLrcStr = timeContentStr.replacingOccurrences(of: "[", with: "")
            
            let timeAndContent = resultLrcStr.components(separatedBy: "]")
            
            if timeAndContent.count != 2 {
                continue
            }
            let time = timeAndContent[0]
            let content = timeAndContent[1]
            
            //创建歌词数据模型，赋值
            let lrcM = QQLrcModel()
            lrcM.beginTime = QQTimeTool.getTimeInterval(formatTime: time)
            lrcM.lrcContent = content
            resultMs.append(lrcM)

        }
        let count = resultMs.count
        for i in 0..<count {
            if i == count - 1 {
                continue
            }
            
            let lrcM = resultMs[i]
            let nextLrcM = resultMs[i+1]
            lrcM.endTime = nextLrcM.beginTime
        }
        
        //4.返回结果
        return resultMs
    }
    
    
    class func getCurrentLrcM(currentTime:TimeInterval,lrcMs:[QQLrcModel])-> (row:Int ,lrcM : QQLrcModel?) {
        var index = 0
        
        for lrcm in lrcMs {
            if currentTime >= lrcm.beginTime && currentTime < lrcm.endTime {
                return (index,lrcm)
            }
            index += 1
        }
        
        return (0,QQLrcModel())
    }
}
