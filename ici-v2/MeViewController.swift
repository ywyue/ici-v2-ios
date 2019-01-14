//
//  ViewController.swift
//  map-test
//
//  Created by Blanketzzz on 2018/9/25.
//  Copyright © 2018年 Blanketzzz. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {
    var topView: UIView! //上半部分背景
    var horizonLineImageView: UIImageView! //水平分界线
    var myCenter: UILabel! //个人中心label
    var meImageView: UIImageView! //头像
    var setImageView: UIImageView! //设置图标
    var editImageView: UIImageView! //编辑资料图标
    var meName: UILabel! //昵称
    var praiseLabel: UILabel! //获赞label
    var praiseNum: UILabel! //获赞
    var myPostClickView:UIView!//我的发布事件点击范围
    var myPostClickGesture:UIGestureRecognizer!//我的发布图标+label点击事件
    var myPostImageView: UIImageView! //我的发布图标
    var myPostLabel: UILabel! //我的发布label
    var myPraiseClickView:UIView!//我的发布事件点击范围
    var myPraiseClickGesture:UIGestureRecognizer!//我的点赞图标+label点击事件
    var myPraiseImageView: UIImageView! //我的点赞图标
    var myPraiseLabel: UILabel! //我的点赞label
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 上半部分背景 */
        topView = UIView(frame:CGRect(x:0,y:0,width:self.view.frame.width,height:600.px()))
        topView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.view.addSubview(topView)
        
        /* 水平分界线 */
        horizonLineImageView = UIImageView(image: UIImage(named: "leftHorizonLine"))
        horizonLineImageView.frame = CGRect(x:0,y:580.px(),width:self.view.frame.width,height:20.px())
        self.view.addSubview(horizonLineImageView)
        
        /* 个人中心label */
        myCenter = UILabel()
        myCenter.frame = CGRect(x:(self.view.frame.width)/2-75.px(),y:75.px(),width:150.px(),height:30.px())
        myCenter.textAlignment = .center
        myCenter.font = UIFont.boldSystemFont(ofSize:30.px())
        myCenter.text = "个人中心"
        myCenter.textColor = UIColor.black
        self.view.addSubview(myCenter)
        
        /* 头像 */
        meImageView = UIImageView(image: UIImage(named: "me"))
        meImageView.frame = CGRect(x:(self.view.frame.width)/2-87.5.px(),y:myCenter.center.y+48.px(),width:195.px(),height:195.px())
        self.view.addSubview(meImageView)
        
        /* 头像外黑色圆圈 */
        let meImageLayer:CALayer = meImageView.layer
        meImageLayer.masksToBounds = true
        meImageLayer.cornerRadius = meImageView.frame.height / 2
        meImageLayer.borderWidth = 10.px()
        meImageLayer.borderColor = UIColor.black.cgColor
        
        /* 设置图标 */
        setImageView = UIImageView(image: UIImage(named: "set"))
        setImageView.frame = CGRect(x:self.view.frame.width-72.px(),y:65.px(),width:40.px(),height:40.px())
        setImageView.isUserInteractionEnabled = true
        self.view.addSubview(setImageView)
        
        /* 编辑资料图标 */
        editImageView = UIImageView(image: UIImage(named: "edit"))
        editImageView.frame = CGRect(x:self.view.frame.width-132.px(),y:65.px(),width:40.px(),height:40.px())
        editImageView.isUserInteractionEnabled = true
        self.view.addSubview(editImageView)
        
        /* 昵称 */
        meName = UILabel()
        meName.frame = CGRect(x:(self.view.frame.width)/2-40,y:meImageView.center.y+120.px(),width:80,height:20.px())
        meName.textAlignment = .center
        meName.font = UIFont.boldSystemFont(ofSize:25.px())
        meName.text = "Evan"
        meName.textColor = UIColor.black
        self.view.addSubview(meName)
        
        /* 获赞label */
        praiseLabel = UILabel()
        praiseLabel.frame = CGRect(x:(self.view.frame.width)/2-70.px(),y:meName.center.y+35.px(),width:65.px(),height:30.px())
        praiseLabel.textAlignment = .center
        praiseLabel.font = UIFont.systemFont(ofSize:30.px())
        praiseLabel.text = "获赞"
        praiseLabel.textColor = UIColor.black
        self.view.addSubview(praiseLabel)
        
        /* 获赞数 */
        praiseNum = UILabel()
        praiseNum.frame = CGRect(x:praiseLabel.center.x+30.px(),y:meName.center.y+35.px(),width:50,height:30.px())
        praiseNum.textAlignment = .center
        praiseNum.font = UIFont.boldSystemFont(ofSize:30.px())
        praiseNum.text = "100"
        praiseNum.textColor = UIColor.black
        self.view.addSubview(praiseNum)
        
        /* 我的发布图标 */
        myPostImageView = UIImageView(image: UIImage(named: "myPost"))
        myPostImageView.frame = CGRect(x:170.px(),y:praiseNum.center.y+50.px(),width:70.px(),height:40.px())
        myPostImageView.isUserInteractionEnabled = true
        self.view.addSubview(myPostImageView)
        
        /* 我的发布label */
        myPostLabel = UILabel()
        myPostLabel.frame = CGRect(x:myPostImageView.center.x-55.px(),y:myPostImageView.center.y+45.px(),width:125.px(),height:30.px())
        myPostLabel.textAlignment = .center
        myPostLabel.font = UIFont.systemFont(ofSize:30.px())
        myPostLabel.text = "我的发布"
        myPostLabel.textColor = UIColor.black
        self.view.addSubview(myPostLabel)
        
        /* 我的发布事件点击范围 */
        myPostClickView = UIView(frame:CGRect(x:170.px(),y:praiseNum.center.y+50.px(),width:125.px(),height:95.px()))
        self.view.addSubview(myPostClickView)
        myPostClickView.isUserInteractionEnabled = true
        myPostClickGesture = UITapGestureRecognizer(target: self, action: #selector(self.myPostClickViewClicked))
        myPostClickView.addGestureRecognizer(myPostClickGesture)
        
        /* 我的点赞图标 */
        myPraiseImageView = UIImageView(image: UIImage(named: "myPraise"))
        myPraiseImageView.frame = CGRect(x:self.view.frame.width-230.px(),y:praiseNum.center.y+40.px(),width:60.px(),height:55.px())
        myPraiseImageView.isUserInteractionEnabled = true
        self.view.addSubview(myPraiseImageView)
        
        /* 我的点赞label */
        myPraiseLabel = UILabel()
        myPraiseLabel.frame = CGRect(x:myPraiseImageView.center.x-60.px(),y:myPostImageView.center.y+45.px(),width:125.px(),height:30.px())
        myPraiseLabel.textAlignment = .center
        myPraiseLabel.font = UIFont.systemFont(ofSize:30.px())
        myPraiseLabel.text = "我的点赞"
        myPraiseLabel.textColor = UIColor.black
        self.view.addSubview(myPraiseLabel)
        
        /* 我的点赞事件点击范围 */
        myPraiseClickView = UIView(frame:CGRect(x:self.view.frame.width-230.px(),y:praiseNum.center.y+40.px(),width:125.px(),height:95.px()))
        self.view.addSubview(myPraiseClickView)
        myPraiseClickView.isUserInteractionEnabled = true
        myPraiseClickGesture = UITapGestureRecognizer(target: self, action: #selector(self.myPraiseClickViewClicked))
        myPraiseClickView.addGestureRecognizer(myPraiseClickGesture)
        
    }
    @objc func myPostClickViewClicked(){
        horizonLineImageView.image = UIImage(named: "leftHorizonLine")
    }
    @objc func myPraiseClickViewClicked(){
        horizonLineImageView.image = UIImage(named: "rightHorizonLine")
    }
    
}

