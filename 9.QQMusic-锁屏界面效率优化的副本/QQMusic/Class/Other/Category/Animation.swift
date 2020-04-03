//
//  Animation.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
//

//cell 动画方法的拓展类
import UIKit
/**
 动画枚举
 */
enum AnimationType {
    case translation //平移
    case scale //缩放
    case rotation //翻转
    case scaleAlways //缩放变大
    case scaleNormal //缩放1
    case none
}
extension UITableViewCell{
    func addAnimation(type : AnimationType) ->() {
        switch type {
            case .translation:
             
                 layer.removeAnimation(forKey: "translation")
                     
                 let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
                 animation.values = [50 , 0 , 50 , 0];
                 animation.duration = 0.7
                 animation.repeatCount = 1
                 layer.add(animation, forKey: "translation")
         
            case .scale:
             
                 layer.removeAnimation(forKey: "scale")
                 let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
                 animation.values = [0.5, 1.0];
                 animation.duration = 0.7
                 animation.repeatCount = 1
                 animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)];
                 
                 layer.add(animation, forKey: "scale")
             
        
             
           case .rotation:
         
                 layer.removeAnimation(forKey: "rotation")
             
                 let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
                 animation.values = [-1 / 6 * Double.pi , 0 , 1 / 6 * Double.pi , 0];
                 animation.duration = 0.7
                 animation.repeatCount = 1
                 layer.add(animation, forKey: "rotation")
             
            case .scaleAlways :
                 //layer.removeAnimation(forKey: "scale")
                 let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
                 animation.values = [1.0, 1.2 ];
                 animation.duration = 0.7
                 animation.repeatCount = 1
                 animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)];
                 animation.isRemovedOnCompletion = false
                 animation.fillMode = CAMediaTimingFillMode.forwards;
                 layer.add(animation, forKey: "scale")
             
            case .scaleNormal:

                 let animation = CAKeyframeAnimation(keyPath: "transform.scale.x")
                 animation.autoreverses = true
                 animation.duration = 0.7
                 animation.repeatCount = 1
                 animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)];

                 layer.add(animation, forKey: "scale")
            
        default:
            break

        }
    }
}
