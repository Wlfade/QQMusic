//
//  CALayer+sz.swift
//  QQMusic
//
//  Created by 单车 on 2020/4/2.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

extension CALayer{
    //暂停动画
    func pauseAnimation(){
        let pausedTime : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
    }
    
    //回复动画
    func resumeAnimate(){
        let pausedTime : CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
        
        
    }
}
