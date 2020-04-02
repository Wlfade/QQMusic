//
//  QQTimeTool.swift
//  QQMusic
//
//  Created by 王玲峰 on 4/1/20.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQTimeTool: NSObject {
    class func getFormatTime(timeInterval:TimeInterval)->String{
        let min = Int(timeInterval) / 60
        let sec = Int(timeInterval) % 60
        
        return String(format: "%02d:%02d",min,sec)
        
    }
    
    
    class func getTimeInterval(formatTime:String) -> TimeInterval {
        //00：00.91
        let minSec = formatTime.components(separatedBy: ":")
        if minSec.count != 2 {
            return 0
        }
        let min = TimeInterval(minSec[0]) ?? 0.0
        let sec = TimeInterval(minSec[1]) ?? 0.0
        
        return min * 60.0 + sec
    }
}


