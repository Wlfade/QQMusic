//
//  QQDetailVC.swift
//  QQMusic
//
//  Created by 单车 on 2020/3/31.
//  Copyright © 2020 单车. All rights reserved.
//

import UIKit

//存放属性
class QQDetailVC: UIViewController {

    //歌词label
    @IBOutlet weak var lrcLabel: UILabel!
    
    //歌曲图片
    @IBOutlet weak var foreImageView: UIImageView!
    @IBOutlet weak var lrcScrollView: UIScrollView!
    
    @IBOutlet weak var progressSlider: UISlider!
    //歌词View
    var lrcView:UIView?

}

//业务逻辑
extension QQDetailVC{
    override func viewDidLoad() {
        super.viewDidLoad()
        addLrcView()
        setUpLrcScrollView()
        setSlide()
    }
}

//MARK:- 界面处理
extension QQDetailVC {
    
    func setSlide(){
        progressSlider.setThumbImage(UIImage(named: "player_slider_playback_thumb"), for: .normal)
    }
    
    //前景图片的处理
    func setUpForeImageView(){
        foreImageView.layer.cornerRadius = foreImageView.width / 2
        foreImageView.layer.masksToBounds = true
    }
    
    //添加歌词视图
    func addLrcView() -> () {
        lrcView = UIView()
        lrcView?.backgroundColor = UIColor.clear
        lrcScrollView.addSubview(lrcView!)
    }
    
    //调整frame
    func setLrcViewFrame() -> () {
        lrcView?.frame = lrcScrollView.bounds;
        lrcView?.left = lrcScrollView.width
    }
    
    //设置scrollView 的属性
    func setUpLrcScrollView() -> () {
        lrcScrollView.delegate = self
        lrcScrollView.isPagingEnabled = true
        lrcScrollView.showsHorizontalScrollIndicator = false
        lrcScrollView.contentSize = CGSize(width: lrcScrollView.width * 2,height: 0)

    }
    
    //状态栏处理
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return UIStatusBarStyle.lightContent
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setLrcViewFrame()
        setUpForeImageView()
    }
}

//MARK:- 动画处理
extension QQDetailVC : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        
        let radio = 1 - x / scrollView.width
        
        foreImageView.alpha = radio
        lrcLabel.alpha = radio
        
    }
}
