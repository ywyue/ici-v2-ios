//
//  ViewController.swift
//  map-test
//
//  Created by Blanketzzz on 2018/9/25.
//  Copyright © 2018年 Blanketzzz. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    var topView: UIView! //上半部分背景
    var todayTaskView: UIView! //今日任务视图
    var activityTaskView: UIView! //活动任务视图
    var horizonLineImageView: UIImageView! //水平分界线
    var questionImageView: UIView! //问题图标图
    var gradeCircleImageView: UIImageView! //积分圆背景图
    var myGradeLable: UILabel! //我的积分label
    var myGrade: UILabel! //我的积分
    var todayTaskClickView:UIView!//今日任务事件点击范围
    var todayTaskClickGesture:UIGestureRecognizer!//今日任务图标+label点击事件
    var todayTaskImageView: UIImageView! //今日任务图标
    var todayTaskLabel: UILabel! //今日任务label
    var activityTaskClickView:UIView!//活动任务事件点击范围
    var activityTaskClickGesture:UIGestureRecognizer!//活动任务图标+label点击事件
    var activityTaskImageView: UIImageView! //活动任务图标
    var activityTaskLabel: UILabel! //活动任务label
    override func viewDidLoad() {
        super.viewDidLoad()
        /* 上半部分背景 */
        topView = UIView(frame:CGRect(x:0,y:0,width:self.view.frame.width,height:650.px()))
        topView.backgroundColor = UIColor(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        self.view.addSubview(topView)
        
        /* 今日任务视图 */
        todayTaskView = UIView(frame:CGRect(x:0,y:630.px(),width:self.view.frame.width,height:590.px()))
       // todayTaskView.backgroundColor = UIColor.white
       // self.view.addSubview(todayTaskView)
        
        /* 水平分界线 */
        horizonLineImageView = UIImageView(image: UIImage(named: "leftHorizonLine"))
        horizonLineImageView.frame = CGRect(x:0,y:630.px(),width:self.view.frame.width,height:20.px())
        self.view.addSubview(horizonLineImageView)
        
        /* 问题图标图 */
        questionImageView = UIImageView(image: UIImage(named: "question"))
        questionImageView.frame = CGRect(x:self.view.frame.width-92.px(),y:90.px(),width:40.px(),height:40.px())
        self.view.addSubview(questionImageView)
        
        /* 积分圆背景图 */
        gradeCircleImageView = UIImageView(image: UIImage(named: "gradeCircle"))
        gradeCircleImageView.frame = CGRect(x:(self.view.frame.width)/2-232.5.px(),y:65.px(),width:465.px(),height:465.px())
        self.view.addSubview(gradeCircleImageView)
        
        /* 我的积分label */
        myGradeLable = UILabel()
        myGradeLable.frame = CGRect(x:gradeCircleImageView.center.x-75.px(),y:gradeCircleImageView.center.y-80.px(),width:150.px(),height:30.px())
        myGradeLable.textAlignment = .center
        myGradeLable.font = UIFont.boldSystemFont(ofSize:30.px())
        myGradeLable.text = "我的积分"
        myGradeLable.textColor = UIColor.white
        self.view.addSubview(myGradeLable)
        
        /* 我的积分 */
        myGrade = UILabel()
        myGrade.frame = CGRect(x:gradeCircleImageView.center.x-82.5.px(),y:gradeCircleImageView.center.y-30.px(),width:165.px(),height:60.px())
        myGrade.textAlignment = .center
        myGrade.font = UIFont.boldSystemFont(ofSize:60.px())
        myGrade.text = "1000"
        myGrade.textColor = UIColor.white
        self.view.addSubview(myGrade)
        
        /* 今日任务图标 */
        todayTaskImageView = UIImageView(image: UIImage(named: "todayTask"))
        todayTaskImageView.frame = CGRect(x:gradeCircleImageView.center.x-183.px(),y:gradeCircleImageView.center.y+215.px(),width:43.px(),height:56.px())
        todayTaskImageView.isUserInteractionEnabled = true
        self.view.addSubview(todayTaskImageView)
        
        /* 今日任务label */
        todayTaskLabel = UILabel()
        todayTaskLabel.frame = CGRect(x:todayTaskImageView.center.x-62.5.px(),y:todayTaskImageView.center.y+45.px(),width:125.px(),height:30.px())
        todayTaskLabel.textAlignment = .center
        todayTaskLabel.font = UIFont.systemFont(ofSize:30.px())
        todayTaskLabel.text = "今日任务"
        todayTaskLabel.textColor = UIColor.black
        self.view.addSubview(todayTaskLabel)
        
        
        /* 今日任务事件点击范围 */
        todayTaskClickView = UIView(frame:CGRect(x:gradeCircleImageView.center.x-183.px(),y:gradeCircleImageView.center.y+215.px(),width:125.px(),height:95.px()))
        self.view.addSubview(todayTaskClickView)
        todayTaskClickView.isUserInteractionEnabled = true
        todayTaskClickGesture = UITapGestureRecognizer(target: self, action: #selector(self.todayTaskClickViewClicked))
        todayTaskClickView.addGestureRecognizer(todayTaskClickGesture)
        
        /* 活动任务图标 */
        activityTaskImageView = UIImageView(image: UIImage(named: "activityTask"))
        activityTaskImageView.frame = CGRect(x:gradeCircleImageView.center.x+150.px(),y:gradeCircleImageView.center.y+210.px(),width:51.px(),height:59.px())
        activityTaskImageView.isUserInteractionEnabled = true
        self.view.addSubview(activityTaskImageView)
        
        /* 活动任务label */
        activityTaskLabel = UILabel()
        activityTaskLabel.frame = CGRect(x:activityTaskImageView.center.x-62.5.px(),y:todayTaskImageView.center.y+45.px(),width:125.px(),height:30.px())
        activityTaskLabel.textAlignment = .center
        activityTaskLabel.font = UIFont.systemFont(ofSize:30.px())
        activityTaskLabel.text = "活动任务"
        activityTaskLabel.textColor = UIColor.black
        self.view.addSubview(activityTaskLabel)
        
        /* 活动任务事件点击范围 */
        activityTaskClickView = UIView(frame:CGRect(x:gradeCircleImageView.center.x+150.px(),y:gradeCircleImageView.center.y+210.px(),width:125.px(),height:95.px()))
        self.view.addSubview(activityTaskClickView)
        activityTaskClickView.isUserInteractionEnabled = true
        activityTaskClickGesture = UITapGestureRecognizer(target: self, action: #selector(self.activityTaskClickViewClicked))
        activityTaskClickView.addGestureRecognizer(activityTaskClickGesture)
        

    }
    @objc func todayTaskClickViewClicked(){
        horizonLineImageView.image = UIImage(named: "leftHorizonLine")
    }
    @objc func activityTaskClickViewClicked(){
        horizonLineImageView.image = UIImage(named: "rightHorizonLine")
    }
    
}

