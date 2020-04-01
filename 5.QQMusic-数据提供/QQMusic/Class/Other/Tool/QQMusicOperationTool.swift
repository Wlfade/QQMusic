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

    //单首歌曲播放工具
    let tool:QQMusicTool = QQMusicTool()
    
    //播发的音乐列表
    var musicMs : [QQMusicModel] = [QQMusicModel]()
    
    //歌曲信息类模型
    private var musicMesModel = QQMusicMessageModel()
    
    var currentPlayIndex = -1{
        didSet{
            if currentPlayIndex < 0 {
                currentPlayIndex = (musicMs.count) - 1
            }
            if currentPlayIndex > (musicMs.count) - 1 {
                currentPlayIndex = 0
            }
        }
    }
    
    
    

    
}

//方法
extension QQMusicOperationTool {
    func getMusicMessageModel() -> (QQMusicMessageModel) {
        
        //在这里，保持数据的最新状态
        musicMesModel.musicM = musicMs[currentPlayIndex]
        musicMesModel.costTime = (tool.player?.currentTime) ?? 0
        musicMesModel.totalTime = (tool.player?.duration) ?? 0
        musicMesModel.isPlaying = (tool.player?.isPlaying) ?? false
        
        return musicMesModel
    }
    //播放
    func playMusic(musicM:QQMusicModel){
        tool.playMusic(musicName: musicM.filename!)
        
        currentPlayIndex = musicMs.firstIndex(of: musicM)!
//        currentPlayIndex = musicMs.index(of: musicM)!
    }
    //暂停
    func playCurrenMusic(){
                
        let model = musicMs[currentPlayIndex]
        playMusic(musicM: model)
    }
    //暂停
    func pauseCurrenMusic(){
        tool.pauseMusic()
    }
    
    //下一首
    func nextMusic() ->  (){
        currentPlayIndex += 1
        //取出需要播放的音乐数据模型
        let model = musicMs[currentPlayIndex]
        playMusic(musicM: model)
    }
    
    //上一首
    func perMusic() ->  (){
        currentPlayIndex -= 1
        //取出需要播放的音乐数据模型
        let model = musicMs[currentPlayIndex]
        playMusic(musicM: model)
    }
    


}
