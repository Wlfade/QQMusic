//
//  QQImageTool.swift
//  QQMusic
//
//  Created by 单车 on 2020/4/3.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQImageTool: NSObject {
    class func getNewImage(sourceImage : UIImage? , str :String?) -> UIImage?{
        
        //1.容错处理
        guard let image = sourceImage else {
            return nil
        }
        guard let resultStr = str else {
            return image
        }
        
        let size = image.size
        
        //1.开启图形上下文
        UIGraphicsBeginImageContext(size)
        
        //2.绘制大图片
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        //3.绘制文字
        let style = NSMutableParagraphStyle()
        
        style.alignment = .center
        let textRect = CGRect(x: 0, y: 0, width: size.width, height: 18)
        let textDic = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.paragraphStyle : style
        ]
        (resultStr as NSString).draw(in: textRect, withAttributes: textDic)
        
        //4.取出图片
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //5.关闭图形上下文
        UIGraphicsEndImageContext()
        
        return resultImage
        
    }
}
