//
//  QQLrcLabel.swift
//  QQMusic
//
//  Created by 单车 on 2020/4/2.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQLrcLabel: UILabel {

    var radio : CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.red.set()
        
        let fillRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width * radio, height: rect.size.height)
        
        UIRectFillUsingBlendMode(fillRect, .sourceIn)
        
        
        
    }

}
