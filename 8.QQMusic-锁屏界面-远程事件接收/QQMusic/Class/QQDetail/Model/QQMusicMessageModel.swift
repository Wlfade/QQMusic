//
//  QQMusicMessageModel.swift
//  QQMusic
//
//  Created by 单车 on 2020/4/1.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQMusicMessageModel: NSObject {
    var musicM : QQMusicModel?
    
    //已经播放时间
    var costTime : TimeInterval = 0
    
    //总时长
    var totalTime : TimeInterval = 0
    
    //播放状态
    var isPlaying : Bool = false
    
}
