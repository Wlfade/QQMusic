//
//  QQMusicTool.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
// 负责单首歌曲的播放

import UIKit
import AVFoundation

class QQMusicTool: NSObject {
    
    override init() {
        super.init()
        
        //1.获取音频会话
        let session = AVAudioSession.sharedInstance()
        
        do {
            //2.设置会话类型（后台播放）
            try session.setCategory(AVAudioSession.Category.playback)
            
            //3.激活会话
            try session.setActive(true)
            
        }
        catch{
            print(errno)
            return
        }
    }
    
    var player : AVAudioPlayer?
    
    func playMusic(musicName:String){
        //1.获取需要播放的音乐文件路径
        guard let url = Bundle.main.url(forResource: musicName, withExtension: nil) else {
            return
        }
        //同一首歌重复点击过滤
        if player?.url == url {
            player?.play()
            return
        }
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
        }catch{
            print(error)
            return
        }
        //3.准备播放
        player?.prepareToPlay()
        //4.开始播放
        player?.play()
        
        
    }
    
    func pauseMusic()->(){
        player?.pause()
    }

}
