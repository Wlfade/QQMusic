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
    lazy var lrcTVC : QQLrcTVC = {
        return QQLrcTVC()
    }()
    
    //--------  实时更新
    /** 歌词label */
    @IBOutlet weak var lrcLabel: QQLrcLabel!
    /** 播放时长 */
    @IBOutlet weak var costTimeLabel: UILabel!
    /** 进度条 */
    @IBOutlet weak var progressSlider: UISlider!
    
    
    @IBOutlet weak var playOrPauseBtn: UIButton!
    //负责更新的计时器
    var timer:Timer?
    
    var updateLrcLink : CADisplayLink?
    
    
}

//业务逻辑
extension QQDetailVC{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpOnce()
        addTimer()
        addLink()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeTimer()
        removeLink()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLrcView()
        setUpLrcScrollView()
        setSlide()
        
//        //打开摇一摇功能
//        UIApplication.shared.applicationSupportsShakeToEdit = true
//        //让需要摇动的控制器成为第一响应者
//        self.becomeFirstResponder()

    }
    //关闭 视图
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //播放或暂停
    @IBAction func playOrPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            //选中是暂停 状态
            QQMusicOperationTool.shareInstance.pauseCurrenMusic()
            pauseRotationAnimation()
        }else{
            //普通是播放 状态
            QQMusicOperationTool.shareInstance.playCurrenMusic()
            resumeRotationAnimation()
        }
    }
    
    //上一首
    @IBAction func preMusic() {
        QQMusicOperationTool.shareInstance.preMusic()

        setUpOnce()

    }
    //下一首
    @IBAction func nextMusic() {
        QQMusicOperationTool.shareInstance.nextMusic()

        setUpOnce()

    }
    
    //赋值1次
    func setUpOnce() -> () {
        
        let musicMessageM = QQMusicOperationTool.shareInstance.getMusicMessageModel()
        
        guard let musicM = musicMessageM.musicM else{
            return
        }
        
        /** 背景图片 */
        if musicM.icon != nil {
            backImageView.image = UIImage(named: (musicM.icon)!)
            /** 前景图片 */
            foreImageView.image = UIImage(named: (musicM.icon)!)
        }
        /** 歌曲名 */
        songNameLabel.text = musicM.name
        /** 歌手名 */
        singerNameLabel.text = musicM.singer
      
        /** 总时长 */
        totalTimeLabel.text = QQTimeTool.getFormatTime(timeInterval: musicMessageM.totalTime)
        /** 歌词View */
//        lrcView
        //切换最新的歌词
        let lrcMs = QQMusicDataTool.getLrcMs(lrcName: musicM.lrcname)
        
        lrcTVC.lrcMs = lrcMs
        
        addRotationAnimation()
        
        if musicMessageM.isPlaying {
            resumeRotationAnimation()
        }else{
            pauseRotationAnimation()
        }
    }
    @objc func setUpTimes() -> () {
        let musicMessageM = QQMusicOperationTool.shareInstance.getMusicMessageModel()
        
        /** 歌词label */
//        lrcLabel.text = ""

        /** 进度条 */
        progressSlider.value = Float(musicMessageM.costTime / musicMessageM.totalTime)
        
        /** 播放时长 */
        costTimeLabel.text = QQTimeTool.getFormatTime(timeInterval: musicMessageM.costTime)
        
        playOrPauseBtn.isSelected = !musicMessageM.isPlaying
    }

    
    //MARK: 添加计时器
    func addTimer(){
        timer = Timer(timeInterval: 1, target: self, selector: #selector(QQDetailVC.setUpTimes), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    //MARK: 移除计时器
    func removeTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    
    func addLink()->(){
        updateLrcLink = CADisplayLink(target: self, selector: #selector(QQDetailVC.updateLrc))
        updateLrcLink?.add(to: RunLoop.current, forMode: .common)
    }
    func removeLink()->(){
        updateLrcLink?.invalidate()
        updateLrcLink = nil
    }
    
    @objc func updateLrc() -> () {
        let musicMessageM = QQMusicOperationTool.shareInstance.getMusicMessageModel()
        
        //拿到歌词
        //当前 时间
        let time = musicMessageM.costTime
        //歌词数组
        let lrcMs = lrcTVC.lrcMs
        
        let rowLrcm = QQMusicDataTool.getCurrentLrcM(currentTime: time, lrcMs: lrcMs)
        
        let lrcM = rowLrcm.lrcM
        
        //歌词赋值
        lrcLabel.text = lrcM?.lrcContent
        
        if lrcM != nil {
            let time1 = (time - lrcM!.beginTime)
            let time2 = (lrcM!.endTime - lrcM!.beginTime)
            lrcLabel.radio = CGFloat(time1 / time2)
        }
        //进度
        lrcTVC.progress = lrcLabel.radio
    
        let row = rowLrcm.row
        
        lrcTVC.scrollRow = row
        
        QQMusicOperationTool.shareInstance.setUpLockMessage()
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
        lrcTVC.tableView?.backgroundColor = UIColor.clear
        lrcScrollView.addSubview(lrcTVC.tableView!)
    }
    
    //调整frame
    func setLrcViewFrame() -> () {
        lrcTVC.tableView?.frame = lrcScrollView.bounds;
        lrcTVC.tableView?.left = lrcScrollView.width
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
    //添加旋转动画
    func addRotationAnimation(){
        foreImageView.layer.removeAnimation(forKey: "rotation")
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0
        animation.toValue = Double.pi * 2
        animation.duration = 30
        animation.isRemovedOnCompletion = false
        animation.repeatCount = MAXFLOAT
        foreImageView.layer.add(animation, forKey: "rotation")
    }
    //暂停旋转动画
    func pauseRotationAnimation(){
        foreImageView.layer.pauseAnimation()
    }
    //继续旋转动画
    func resumeRotationAnimation(){
        foreImageView.layer.resumeAnimate()
    }
    
}

extension QQDetailVC {
    override func remoteControlReceived(with event: UIEvent?) {
        let type = event?.subtype
        switch type! {
        case .remoteControlPlay:
            print("播放")
            QQMusicOperationTool.shareInstance.playCurrenMusic()
            
        case .remoteControlPause:
            print("暂停")
            QQMusicOperationTool.shareInstance.pauseCurrenMusic()

        case .remoteControlNextTrack:
            print("下一首")
            QQMusicOperationTool.shareInstance.nextMusic()

        case .remoteControlPreviousTrack:
            print("上一首")
            QQMusicOperationTool.shareInstance.preMusic()
        default:
            print("nono")
        }
        
        setUpOnce()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        QQMusicOperationTool.shareInstance.nextMusic()
        setUpOnce()
    }
}
