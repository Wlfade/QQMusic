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

    /** 滑动视图 */
    @IBOutlet weak var lrcScrollView: UIScrollView!

    
    //分析界面，根据不同的更新评率，采用不同的方案赋值
    //--------  赋值1次
    /** 背景图片 */
    @IBOutlet weak var backImageView: UIImageView!
    /** 歌曲名 */
    @IBOutlet weak var songNameLabel: UILabel!
    /** 歌手名 */
    @IBOutlet weak var singerNameLabel: UILabel!
    /** 前景图片 */
    @IBOutlet weak var foreImageView: UIImageView!
    /** 总时长 */
    @IBOutlet weak var totalTimeLabel: UILabel!
    /** 歌词View */
    var lrcView:UIView?
    
    //--------  实时更新
    /** 歌词label */
    @IBOutlet weak var lrcLabel: UILabel!
    /** 播放时长 */
    @IBOutlet weak var costTimeLabel: UILabel!
    /** 进度条 */
    @IBOutlet weak var progressSlider: UISlider!
    
    
    //负责更新的计时器
    var timer:Timer?
    
}

//业务逻辑
extension QQDetailVC{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpOnce()
        addTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLrcView()
        setUpLrcScrollView()
        setSlide()
    }
    //关闭 视图
    @IBAction func close() {
        
    }
    
    //播放或暂停
    @IBAction func playOrPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            //选中是暂停 状态
            QQMusicOperationTool.shareInstance.pauseCurrenMusic()
        }else{
            //普通是播放 状态
            QQMusicOperationTool.shareInstance.playCurrenMusic()
        }
    }
    
    //上一首
    @IBAction func preMusic() {
        setUpOnce()
        QQMusicOperationTool.shareInstance.perMusic()

    }
    //下一首
    @IBAction func nextMusic() {
        setUpOnce()
        QQMusicOperationTool.shareInstance.nextMusic()

    }
    
    //赋值1次
    func setUpOnce() -> () {
        /** 背景图片 */
        backImageView.image = nil
        /** 歌曲名 */
        songNameLabel.text = ""
        /** 歌手名 */
        singerNameLabel.text = ""
        /** 前景图片 */
        foreImageView.image = nil
        /** 总时长 */
        totalTimeLabel.text = ""
        /** 歌词View */
//        lrcView
    }
    @objc func setUpTimes() -> () {
        /** 歌词label */
        lrcLabel.text = ""
        /** 播放时长 */
        costTimeLabel.text = "00:00"
        /** 进度条 */
        progressSlider.value = 0.0
    }

    func addTimer(){
        timer = Timer(timeInterval: 1, target: self, selector: #selector(QQDetailVC.setUpTimes), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    func removeTimer(){
        timer?.invalidate()
        timer = nil
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
