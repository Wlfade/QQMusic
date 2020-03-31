//
//  QQMusicOperationTool.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQMusicOperationTool: NSObject {
    
    static let shareInstance = QQMusicOperationTool()
    
    let tool:QQMusicTool = QQMusicTool()
    func playMusic(musicM:QQMusicModel){
        tool.playMusic(musicName: musicM.filename!)
    }
    
}
