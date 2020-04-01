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
}
