//
//  ViewController.swift
//  ici-v2
//
//  Created by Blanketzzz on 2018/9/25.
//  Copyright © 2018年 Blanketzzz. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var messageTitleLabel: UILabel! //消息标题
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* 消息标题 */
        messageTitleLabel = UILabel()
        messageTitleLabel.frame = CGRect(x:52.px(),y:98.px(),width:120.px(),height:54.px())
        messageTitleLabel.textAlignment = .left
        messageTitleLabel.font = UIFont.boldSystemFont(ofSize:54.px())
        messageTitleLabel.text = "消息"
        messageTitleLabel.textColor = UIColor.black
        self.view.addSubview(messageTitleLabel)
        
        let screenRect = UIScreen.main.bounds
        let tabelRect = CGRect(x:0.px(),y:234.px(),width:screenRect.size.width,height:screenRect.size.height-234.px())
        let tabelView = UITableView(frame: tabelRect)
        tabelView.dataSource = self
        tabelView.delegate = self
        
        self.view.addSubview(tabelView)
        /*
        let frame = CGRect(x: 0, y: 125.px(), width: self.view.frame.width,height: 125.px())
        let cgView = CGView(frame: frame)
        setShadow(view: cgView, sColor: UIColor.gray, offset: CGSize.init(width:0.0,height:-22), opacity: 0.2, radius: 5)
        self.view.addSubview(cgView)*/
    }
    
    //设置每一个消息栏的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 147.px()
    }
    
    //设置消息栏数目
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //定义每个消息栏的具体内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "messageCell"
        var cell:CustomizeUITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomizeUITableViewCell
        
        if(cell == nil)
        {
            cell = CustomizeUITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        if(indexPath as NSIndexPath).row == 1
        {
            cell?.cellImage?.image = UIImage(named: "comment")
            cell?.title?.text = "评论"
        }
        if(indexPath as NSIndexPath).row == 2
        {
            cell?.cellImage?.image = UIImage(named: "iciOfficial")
            cell?.title?.text = "ici官方"
            cell?.title?.frame = CGRect(x:167.px(),y:45.px(),width:100.px(),height:25.px())
            cell?.title?.font = UIFont.boldSystemFont(ofSize:25.px())
            
            cell?.arrowImage?.image = nil
            cell?.detail?.text = "这次的活动是什么你知道吗？"
            cell?.date?.text = "星期三"
       
            
        }
    
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



/* 画直线 */
class CGView:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置背景色为透明，否则是黑色背景
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //获取绘图上下文
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        //创建并设置路径
        let path = CGMutablePath()
        
        //画线
        path.move(to: CGPoint(x: 0, y: self.bounds.minY))
        path.addLine(to: CGPoint(x: self.bounds.maxX, y: self.bounds.minY))
       
        //添加路径到图形上下文
        context.addPath(path)
        
        
        //设置笔触颜色
        context.setStrokeColor(UIColor.lightGray.cgColor)
        //设置笔触宽度
        context.setLineWidth(1)
        //设置阴影
        context.setShadow(offset: CGSize(width:0, height:3), blur: 6,
                          color: UIColor.lightGray.cgColor)
        //绘制路径
        context.strokePath()
    }
    
}


//自定义消息栏视图
class CustomizeUITableViewCell:UITableViewCell{
    var cellImage:UIImageView!
    var title:UILabel!
    var detail:UILabel!
    var arrowImage:UIImageView!
    var date:UILabel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.cellImage = UIImageView(image: UIImage(named: "praise"))
        self.cellImage.frame = CGRect(x:50.px(),y:30.px(),width:90.px(),height:90.px())
        
        self.title = UILabel()
        self.title.frame = CGRect(x:167.px(),y:self.cellImage.center.y-12.5.px(),width:60.px(),height:25.px())
        self.title.textAlignment = .left
        self.title.font = UIFont.systemFont(ofSize:25.px())
        self.title.text = "点赞"
        self.title.textColor = UIColor.black
        
        self.arrowImage = UIImageView(image: UIImage(named: "arrow"))
        self.arrowImage.frame = CGRect(x:660.px(),y:self.cellImage.center.y-18.5.px(),width:25.px(),height:37.px())
        
        self.detail = UILabel()
        self.detail.frame = CGRect(x:167.px(),y:85.px(),width:400.px(),height:20.px())
        self.detail.textAlignment = .left
        self.detail.font = UIFont.systemFont(ofSize:20.px())
        self.detail.textColor = UIColor.gray
        
        self.date = UILabel()
        self.date = UILabel()
        self.date.frame = CGRect(x:605.px(),y:45.px(),width:100.px(),height:22.px())
        self.date.textAlignment = .left
        self.date.font = UIFont.systemFont(ofSize:22.px())
        self.date.textColor = UIColor.gray
        
        self.addSubview(self.cellImage)
        self.addSubview(self.title)
        self.addSubview(self.arrowImage)
        self.addSubview(self.detail)
        self.addSubview(self.date)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:)has not brrn implomented")
    }
}
