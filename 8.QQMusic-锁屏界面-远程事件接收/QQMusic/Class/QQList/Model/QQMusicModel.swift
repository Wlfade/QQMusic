//
//  QQMusicModel.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

class QQMusicModel: NSObject {
    /** 歌曲名称 */
    @objc var name: String?
    /** 歌曲文件名称 */
    @objc var filename: String?
    /** 歌词文件名称 */
    @objc var lrcname: String?
    /** 歌手名称 */
    @objc var singer: String?
    /** 歌手头像名称 */
    @objc var singerIcon: String?
    /** 专辑头像图片 */
    @objc var icon: String?
    
    override init() {
        super.init()
    }
    
    init(dic : [String : AnyObject]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        return  dictionaryWithValues(forKeys: ["name","filename","lrcname"]).description
    }
}
