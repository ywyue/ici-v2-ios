//
//  ViewController.swift
//  ici-v2
//
//  Created by Blanketzzz on 2018/9/25.
//  Copyright © 2018年 Blanketzzz. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    var taskTitleLabel: UILabel! //任务标题
    var todayTaskView: UIView! //今日任务视图
    var activityTaskView: UIView! //活动任务视图

    var scoreBackgroundImageView: UIImageView! //积分背景
    var questionImageView: UIView! //问题图标
    var scoreImageView: UIImageView! //积分图标
    var myScore: UILabel! //我的积分
    

    var todayTaskImageView: UIImageView! //今日任务图标
    var todayTaskLabel: UILabel! //今日任务label
    var verticalLine:UIImageView! //垂线
    var todayTaskNotes:UILabel! //今日任务注释

    var activityTaskImageView: UIImageView! //活动任务图标
    var activityTaskLabel: UILabel! //活动任务label
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 任务标题 */
        taskTitleLabel = UILabel()
        taskTitleLabel.frame = CGRect(x:52.px(),y:98.px(),width:230.px(),height:54.px())
        taskTitleLabel.textAlignment = .left
        taskTitleLabel.font = UIFont.boldSystemFont(ofSize:54.px())
        taskTitleLabel.text = "任务中心"
        taskTitleLabel.textColor = UIColor.black
        self.view.addSubview(taskTitleLabel)
        
        
        
        /* 积分背景图 */
        scoreBackgroundImageView = UIImageView(image: UIImage(named: "scoreBgImg"))
        scoreBackgroundImageView.frame = CGRect(x:50.px(),y:221.px(),width:654.px(),height:246.px())
        self.view.addSubview(scoreBackgroundImageView)
        
        /* 问题图标 */
        questionImageView = UIImageView(image: UIImage(named: "question"))
        questionImageView.frame = CGRect(x:570.px(),y:20.px(),width:40.px(),height:40.px())
        scoreBackgroundImageView.addSubview(questionImageView)
        
        /* 积分图标 */
        scoreImageView = UIImageView(image: UIImage(named: "scoreBig"))
        scoreImageView.frame = CGRect(x:146.px(),y:68.px(),width:106.px(),height:106.px())
        scoreBackgroundImageView.addSubview(scoreImageView)
        
        /* 我的积分 */
        myScore = UILabel()
        myScore.frame = CGRect(x:292.px(),y:scoreImageView.center.y-32.5.px(),width:165.px(),height:65.px())
        myScore.textAlignment = .left
        myScore.font = UIFont.boldSystemFont(ofSize:65.px())
        myScore.text = "1000"
        myScore.textColor = UIColor.black
        scoreBackgroundImageView.addSubview(myScore)
    
        /* 今日任务label */
        todayTaskLabel = UILabel()
        todayTaskLabel.frame = CGRect(x:60.px(),y:517.px(),width:150.px(),height:31.px())
        todayTaskLabel.textAlignment = .left
        todayTaskLabel.font = UIFont.systemFont(ofSize:31.px())
        todayTaskLabel.text = "今日任务"
        todayTaskLabel.textColor = UIColor.black
        self.view.addSubview(todayTaskLabel)
        
        /* 垂线 */
        verticalLine = UIImageView(image: UIImage(named: "verticalLine"))
        verticalLine.frame = CGRect(x:220.px(),y:todayTaskLabel.center.y-14.px(),width:2.px(),height:28.px())
        self.view.addSubview(verticalLine)
        
        /* 今日任务label */
        todayTaskNotes = UILabel()
        todayTaskNotes.frame = CGRect(x:240.px(),y:todayTaskLabel.center.y-12.5.px(),width:280.px(),height:25.px())
        todayTaskNotes.textAlignment = .left
        todayTaskNotes.font = UIFont.systemFont(ofSize:25.px())
        todayTaskNotes.text = "完成任务可获取积分"
        todayTaskNotes.textColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        self.view.addSubview(todayTaskNotes)

        /*
        /* 活动任务label */
        activityTaskLabel = UILabel()
        activityTaskLabel.frame = CGRect(x:activityTaskImageView.center.x-62.5.px(),y:todayTaskImageView.center.y+45.px(),width:125.px(),height:30.px())
        activityTaskLabel.textAlignment = .center
        activityTaskLabel.font = UIFont.systemFont(ofSize:30.px())
        activityTaskLabel.text = "活动任务"
        activityTaskLabel.textColor = UIColor.black
        self.view.addSubview(activityTaskLabel)
        */
        

    }
   
    
}

