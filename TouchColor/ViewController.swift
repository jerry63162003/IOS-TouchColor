//
//  ViewController.swift
//  TouchColor
//
//  Created by roy on 2018/9/20.
//  Copyright © 2018年 roy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    var tracker: TrackerProtocol?
    
    let gameConfig = GameConfig.shared
    
//    private let gai: GAI = {
//        guard let gai = GAI.sharedInstance() else { fatalError("Google Analytics not configured correctly") }
//        gai.trackUncaughtExceptions = true
//        gai.dispatchInterval = 20
//        return gai
//    }()
    
    lazy var explainView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image: #imageLiteral(resourceName: "组2"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
            make.height.equalTo(328)
            make.width.equalTo(268)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "叉"), for: .normal)
        cancelButton.tag = 21
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.height.width.equalTo(35)
            make.top.equalTo(bgImage).offset(-35)
            
            let height = UIScreen.main.bounds.size.height
            if height == 480 || height == 568 {
                make.right.equalTo(bgImage).offset(0)
            }else {
                make.right.equalTo(bgImage).offset(40)
            }
        })
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.text = "\n 1、在6x10的游戏界面矩阵中，界面会随机出现各种颜色小点 \n 2、拖动一个小点到相同颜色的另一小点的位置上即可同时消除两个小点并得到10分 \n 3、小点出现的速度会随着游戏的进行越发加快，最后小点占据整个矩阵时游戏结束 \n 4、没有时间限制，考验你眼疾手快的能力，快来挑战吧"
        bgImage.addSubview(label)
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(bgImage).offset(61)
            make.left.equalTo(bgImage).offset(41)
            make.right.equalTo(bgImage).offset(-41)
        })
        
        return bgView
    }()
    
    lazy var settingView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.clear
        
        let alphaView = UIView()
        alphaView.backgroundColor = UIColor.black
        alphaView.alpha = 0.8
        bgView.addSubview(alphaView)
        alphaView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(bgView)
        }
        
        let bgImage = UIImageView(image: #imageLiteral(resourceName: "组2拷贝3"))
        bgImage.isUserInteractionEnabled = true
        bgView.addSubview(bgImage)
        bgImage.snp.makeConstraints { (make) in
            make.center.equalTo(bgView)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(#imageLiteral(resourceName: "叉"), for: .normal)
        cancelButton.tag = 31
        cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints({ (make) in
            make.height.width.equalTo(35)
            make.top.equalTo(bgImage).offset(-30)
            
            let height = UIScreen.main.bounds.size.height
            if height == 480 || height == 568 {
                make.right.equalTo(bgImage).offset(0)
            }else {
                make.right.equalTo(bgImage).offset(40)
            }
        })
        
        let label1 = UILabel()
        label1.textColor = UIColor.white
        label1.text = "音乐"
        label1.font = UIFont.systemFont(ofSize: 16)
        bgImage.addSubview(label1)
        label1.snp.makeConstraints({ (make) in
            make.left.equalTo(bgImage).offset(77)
            make.top.equalTo(bgImage).offset(102)
        })
        
        let label2 = UILabel()
        label2.textColor = UIColor.white
        label2.text = "音效"
        label2.font = UIFont.systemFont(ofSize: 16)
        bgImage.addSubview(label2)
        label2.snp.makeConstraints({ (make) in
            make.left.equalTo(bgImage).offset(77)
            make.top.equalTo(bgImage).offset(156)
        })
        
        let musicButton = UIButton()
        musicButton.isSelected = gameConfig.isGameMusic
        musicButton.setImage(#imageLiteral(resourceName: "on"), for: .selected)
        musicButton.setImage(#imageLiteral(resourceName: "off"), for: .normal)
        musicButton.tag = 10
        musicButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(musicButton)
        musicButton.snp.makeConstraints({ (make) in
            make.left.equalTo(bgImage).offset(133)
            make.top.equalTo(bgImage).offset(97)
        })
        
        let soundButton = UIButton()
        soundButton.isSelected = gameConfig.isGameSound
        soundButton.setImage(#imageLiteral(resourceName: "on"), for: .selected)
        soundButton.setImage(#imageLiteral(resourceName: "off"), for: .normal)
        soundButton.tag = 11
        soundButton.addTarget(self, action: #selector(settingClick(_:)), for: .touchUpInside)
        bgImage.addSubview(soundButton)
        soundButton.snp.makeConstraints({ (make) in
            make.left.equalTo(bgImage).offset(133)
            make.top.equalTo(bgImage).offset(149)
        })
        
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        button.tag = 30
        button.setImage(#imageLiteral(resourceName: "关于我们"), for: .normal)
        bgImage.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgImage)
            make.bottom.equalTo(bgImage).offset(-66)
        }
        
        return bgView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        tracker?.trackScreenWithName(screenName: "StartViewController")
    }
    
    override func viewDidLoad() {
//        tracker = Tracker(gaiTracker: gai.defaultTracker)
        scoreLabel.text = "最高分:\(gameConfig.highScore)"
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        if sender.tag == 10 {
            openGameExplain()
        }
        if sender.tag == 11 {
            let gameViewController = GameViewController(name: "game")
            present(gameViewController, animated: true, completion: nil)
        }
        if sender.tag == 12 {
            openSetting()
        }
        if sender.tag == 21 {
            explainView.removeFromSuperview()
        }
        if sender.tag == 30 {
            let webview = WebViewController()
            webview.urlStr = "http://static.nichanglai.com/index.html"

            present(webview, animated: true, completion: nil)
        }
        if sender.tag == 31 {
            settingView.removeFromSuperview()
        }
    }
    
    @objc func settingClick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.tag == 10 {
            gameConfig.isGameMusic = sender.isSelected
        }
        if sender.tag == 11 {
            gameConfig.isGameSound = sender.isSelected
        }
    }
    
    func openGameExplain() {
        view.addSubview(explainView)
        explainView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }
    
    func openSetting() {
        view.addSubview(settingView)
        settingView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
    }
}

