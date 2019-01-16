//
//  ViewController.swift
//  ici-v2
//
//  Created by Blanketzzz on 2018/9/25.
//  Copyright © 2018年 Blanketzzz. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    var topView: UIView! //标题部分背景
    var messageLabel: UILabel! //消息标题
    override func viewDidLoad() {
        super.viewDidLoad()
        /* 标题部分背景 */
        topView = UIView(frame:CGRect(x:0,y:0,width:self.view.frame.width,height:125.px()))
        topView.backgroundColor = UIColor.white
        setShadow(view: topView, sColor: UIColor.gray, offset: CGSize.init(width:0.0,height:3), opacity: 0.2, radius: 5)
        self.view.addSubview(topView)
        
        /* 消息标题 */
        messageLabel = UILabel()
        messageLabel.frame = CGRect(x:(self.view.frame.width)/2-37.5.px(),y:topView.center.y+10.px(),width:75.px(),height:30.px())
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize:30.px())
        messageLabel.text = "消息"
        messageLabel.textColor = UIColor.black
        self.view.addSubview(messageLabel)
        
        /*
        let frame = CGRect(x: 0, y: 125.px(), width: self.view.frame.width,height: 125.px())
        let cgView = CGView(frame: frame)
        setShadow(view: cgView, sColor: UIColor.gray, offset: CGSize.init(width:0.0,height:-22), opacity: 0.2, radius: 5)
        self.view.addSubview(cgView)*/
    }
    
}


func setShadow(view:UIView,sColor:UIColor,offset:CGSize,
               opacity:Float,radius:CGFloat) {
    //设置阴影颜色
    view.layer.shadowColor = sColor.cgColor
    //设置透明度
    view.layer.shadowOpacity = opacity
    //设置阴影半径
    view.layer.shadowRadius = radius
    //设置阴影偏移量
    view.layer.shadowOffset = offset
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
