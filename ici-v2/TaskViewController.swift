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
    var todayTaskverticalLine:UIImageView! //垂线
    var todayTaskNotes:UILabel! //今日任务注释

    var activityTaskImageView: UIImageView! //活动任务图标
    var activityTaskLabel: UILabel! //活动任务label
    var activityTaskverticalLine:UIImageView! //垂线
    var activityTaskNotes:UILabel! //活动任务注释
    
    var todayTaskCells:Array<taskCellView>!
    var activityTaskCells:Array<taskCellView>!
    var activityScrollView:UIScrollView!
    
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
        todayTaskverticalLine = UIImageView(image: UIImage(named: "verticalLine"))
        todayTaskverticalLine.frame = CGRect(x:220.px(),y:todayTaskLabel.center.y-14.px(),width:2.px(),height:28.px())
        self.view.addSubview(todayTaskverticalLine)
        
        /* 今日任务说明label */
        todayTaskNotes = UILabel()
        todayTaskNotes.frame = CGRect(x:240.px(),y:todayTaskLabel.center.y-12.5.px(),width:280.px(),height:25.px())
        todayTaskNotes.textAlignment = .left
        todayTaskNotes.font = UIFont.systemFont(ofSize:25.px())
        todayTaskNotes.text = "完成任务可获取积分"
        todayTaskNotes.textColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        self.view.addSubview(todayTaskNotes)
        
        
        todayTaskCells = Array<taskCellView>()
        for index in 0 ..< 2{
            let todayTaskCell = taskCellView()
            todayTaskCells.append(todayTaskCell)
            todayTaskCells[index].taskImageView = UIImageView(image: UIImage(named: "todayTask"))
            todayTaskCells[index].taskName.text = "每日登陆"
            todayTaskCells[index].taskDescription.text = "积分+30"
            todayTaskCells[index].taskBtnLabel.text = "领取"
            todayTaskCells[index].frame = CGRect(x:50.px(),y:574.px()+160.px()*CGFloat(index),width:654.px(),height:140.px())
            self.view.addSubview(todayTaskCells[index])
//            todayScrollView.alwaysBounceVertical = true
//            todayScrollView.isScrollEnabled = true
//            self.view.addSubview(todayScrollView)
        }

        /* 活动任务label */
        activityTaskLabel = UILabel()
        activityTaskLabel.frame = CGRect(x:60.px(),y:
            596.px()+CGFloat(todayTaskCells.count)*160.px(),width:150.px(),height:31.px())
        activityTaskLabel.textAlignment = .left
        activityTaskLabel.font = UIFont.systemFont(ofSize:31.px())
        activityTaskLabel.text = "活动任务"
        activityTaskLabel.textColor = UIColor.black
        self.view.addSubview(activityTaskLabel)
        
        /* 垂线 */
        activityTaskverticalLine = UIImageView(image: UIImage(named: "verticalLine"))
        activityTaskverticalLine.frame = CGRect(x:220.px(),y:activityTaskLabel.center.y-14.px(),width:2.px(),height:28.px())
        self.view.addSubview(activityTaskverticalLine)
        
        /* 活动任务说明label */
        activityTaskNotes = UILabel()
        activityTaskNotes.frame = CGRect(x:240.px(),y:activityTaskLabel.center.y-12.5.px(),width:280.px(),height:25.px())
        activityTaskNotes.textAlignment = .left
        activityTaskNotes.font = UIFont.systemFont(ofSize:25.px())
        activityTaskNotes.text = "参与活动可获取积分"
        activityTaskNotes.textColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1)
        self.view.addSubview(activityTaskNotes)
        
        let activityTaskScrollView = UIScrollView()
        activityTaskScrollView.frame = CGRect(x:50.px(),y:activityTaskLabel.center.y+41.5.px(),width:654.px(),height:500.px())
        
        activityTaskCells = Array<taskCellView>()
        for index in 0 ..< 3{
            let activityTaskCell = taskCellView()
            activityTaskCells.append(activityTaskCell)
            activityTaskCells[index].taskImageView = UIImageView(image: UIImage(named: "activityTask"))
            activityTaskCells[index].taskName.text = "每日登陆"
            activityTaskCells[index].taskDescription.text = "积分+30"
            activityTaskCells[index].taskBtnLabel.text = "前往"
            activityTaskCells[index].frame = CGRect(x:0,y:160.px()*CGFloat(index),width:654.px(),height:140.px())
            activityTaskScrollView.addSubview(activityTaskCells[index])
        }
        activityTaskScrollView.isPagingEnabled = true
        activityTaskScrollView.alwaysBounceVertical = true
        activityTaskScrollView.isScrollEnabled = true
        self.view.addSubview(activityTaskScrollView)

    }
   
    
}

class taskCellView:UIView{
    var taskBackgroundImageView = UIImageView()
    var taskImageView = UIImageView()
    var taskName = UILabel()
    var taskDescription = UILabel()
    var taskBtnImageView = UIImageView()
    var taskBtnLabel = UILabel()
    override init(frame:CGRect)
    {
        super.init(frame:frame)
    }
    
    override func draw(_ rect: CGRect)
    {
        self.taskBackgroundImageView = UIImageView(image: UIImage(named: "taskBgImg"))
        self.taskBackgroundImageView.frame = CGRect(x:0,y:0,width:654.px(),height:140.px())
        
        self.taskImageView.frame = CGRect(x:26.px(),y:13.px(),width:103.px(),height:103.px())
        
        self.taskName.frame = CGRect(x:155.px(),y:30.px(),width:120.px(),height:25.px())
        self.taskName.textAlignment = .left
        self.taskName.font = UIFont.boldSystemFont(ofSize:25.px())
        self.taskName.textColor = UIColor.black
        
        self.taskDescription.frame = CGRect(x:155.px(),y:75.px(),width:100.px(),height:18.px())
        self.taskDescription.textAlignment = .left
        self.taskDescription.font = UIFont.boldSystemFont(ofSize:18.px())
        self.taskDescription.textColor = UIColor(red: 109/255, green: 103/255, blue: 103/255, alpha: 1)
        
        self.taskBtnImageView = UIImageView(image: UIImage(named: "taskBtnImg"))
        self.taskBtnImageView.frame = CGRect(x:485.px(),y:35.px(),width:127.px(),height:58.px())
        
        self.taskBtnLabel.frame = CGRect(x:523.px(),y:53.px(),width:100.px(),height:27.px())
        self.taskBtnLabel.textAlignment = .left
        self.taskBtnLabel.font = UIFont.boldSystemFont(ofSize:27.px())
        self.taskBtnLabel.textColor = UIColor.black
        
        self.addSubview(taskBackgroundImageView)
        self.addSubview(taskImageView)
        self.addSubview(taskName)
        self.addSubview(taskDescription)
        self.addSubview(taskBtnImageView)
        self.addSubview(taskBtnLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
