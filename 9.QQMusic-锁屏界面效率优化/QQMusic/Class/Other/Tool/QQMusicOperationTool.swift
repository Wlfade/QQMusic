//
//  QQMusicOperationTool.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit
import MediaPlayer
class QQMusicOperationTool: NSObject {
    
    var lastRow = -1
    
    var artWork : MPMediaItemArtwork?
    
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
    func preMusic() ->  (){
        currentPlayIndex -= 1
        //取出需要播放的音乐数据模型
        let model = musicMs[currentPlayIndex]
        playMusic(musicM: model)
    }
    
    //设置锁屏信息
    func setUpLockMessage() -> () {
        //取出需要展示的数据模型
        
        let musicMessageM = getMusicMessageModel()
        
        //1.获取锁屏中心
        let center = MPNowPlayingInfoCenter.default()
        //歌曲名
        let musicName = musicMessageM.musicM?.name ?? ""
        //歌手名
        let singerName = musicMessageM.musicM?.singer ?? ""
        //播放时间
        let costTime = musicMessageM.costTime
        //一共的时间
        let totalTime = musicMessageM.totalTime
        
        let imageName = musicMessageM.musicM?.icon ?? ""
        
        let image = UIImage(named: imageName)
        
        //1.获取当前正在播放的歌词
        let lrcFileName = musicMessageM.musicM?.lrcname
        let lrcMs = QQMusicDataTool.getLrcMs(lrcName: lrcFileName)
        let lrcMRow = QQMusicDataTool.getCurrentLrcM(currentTime: musicMessageM.costTime, lrcMs: lrcMs)
        
        let lrcM = lrcMRow.lrcM
        
        //2.绘制到图片，生成新的图片
        
        var resultImage : UIImage?
        if lastRow != lrcMRow.row{
            lastRow = lrcMRow.row
            
            resultImage = QQImageTool.getNewImage(sourceImage: image, str: lrcM?.lrcContent)

        }
        
        
        if resultImage != nil {
            artWork = MPMediaItemArtwork(boundsSize: image!.size, requestHandler: { (size) -> UIImage in
                return resultImage!
            })
        }
        
        let dic : NSMutableDictionary = [
            MPMediaItemPropertyAlbumTitle : musicName,
//            MPMediaItemPropertyAlbumTitle : lrcM?.lrcContent ?? "",

            MPMediaItemPropertyArtist : singerName,
            MPMediaItemPropertyPlaybackDuration : totalTime,
            MPNowPlayingInfoPropertyElapsedPlaybackTime : costTime,
        ]
        
        if artWork != nil {
            dic.setValue(artWork!, forKey: MPMediaItemPropertyArtwork)
        }
        
        let dicCopy = dic.copy()
        
        //2.锁屏中心赋值
        center.nowPlayingInfo = dicCopy as? [String : AnyObject]
        
        //3.接收远程事件
        UIApplication.shared.beginReceivingRemoteControlEvents()
    }
    
    func seekToTime(time : TimeInterval){
        tool.seekToTime(time: time)
    }
}
