//
//  RootTabBarViewController.swift
//  unionMerchant
//
//  Created by simpsons on 2017/8/16.
//  Copyright © 2017年 simpsons. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController, RootTabBarDelegate{
    
    let tabBarNormalImages = ["MapIcon","TaskIcon","MessageIcon","MeIcon"]
    let tabBarSelectedImages = ["MapIcon_selected","TaskIcon_selected","MessageIcon_selected","MeIcon_selected"]
    let tabBarTitles = ["地图","任务","消息","我的"]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        UITableView.appearance().tableFooterView = UIView()
        //       UITableView.appearance().backgroundColor = UIColor.colorWithHexString("f3f3f5")
        UITableView.appearance().backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tab = RootTabBar()
        tab.addDelegate = self
        self.setValue(tab, forKey: "tabBar")
        self.setRootTabbarConntroller()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 98.px()              //导航栏高度
        tabFrame.origin.y = self.view.frame.size.height - 98.px()
        self.tabBar.frame = tabFrame
        setShadow(view: self.tabBar, sColor: UIColor.gray, offset: CGSize.init(width:0.0,height:-2.0), opacity: 0.2, radius: 5)
    }
    /// 上传按钮执行方法
    func addClick() {
        
        print("add succeed")
        
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
    
    func setRootTabbarConntroller(){
        
        var vc : UIViewController?
        
        for i in 0..<self.tabBarNormalImages.count {
            
            //创建根控制器
            switch i {
            case 0:
                vc = MapViewController()
            case 1:
                vc = TaskViewController()
            case 2:
                vc = MessageViewController()
            case 3:
                vc = MeViewController()
            default:
                break
            }
            
            //创建导航控制器
//            let nav = RootNavigationController.init(rootViewController: vc!)
            
            //1.创建tabbarItem
            let barItem = UITabBarItem.init(title: self.tabBarTitles[i], image: UIImage.init(named: self.tabBarNormalImages[i])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: self.tabBarSelectedImages[i])?.withRenderingMode(.alwaysOriginal))
            barItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5.px())
            barItem.setTitleTextAttributes([kCTFontAttributeName as NSAttributedString.Key : UIFont.systemFont(ofSize: 18.px())], for: .normal)
            
            //2.更改字体颜色
  //          barItem.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key : UIColor.colorWithHexString("cccccc")], for: .normal)
//            barItem.setTitleTextAttributes([kCTForegroundColorAttributeName as NSAttributedString.Key : UIColor.colorWithHexString("21d1c1")], for: .selected)
            
            //设置标题
            vc?.title = self.tabBarTitles[i]
            
            //设置根控制器
            vc?.tabBarItem = barItem
            
            //添加到当前控制器
            self.addChild(vc!)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

/// 上传按钮点击代理
protocol RootTabBarDelegate:NSObjectProtocol {
    func addClick()
}

/// 自定义tabbar，修改UITabBarButton的位置
class RootTabBar: UITabBar {
    
    weak var addDelegate: RootTabBarDelegate?
    
    private lazy var addButton:UIButton = {
        return UIButton()
    }()
    
    private lazy var addButton_front:UIButton = {
        return UIButton()
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        addButton.setBackgroundImage(UIImage.init(named: "white"), for: .normal)
        addButton.addTarget(self, action: #selector(RootTabBar.addButtonClick), for: .touchUpInside)
        addButton_front.setBackgroundImage(UIImage.init(named: "black"), for: .normal)
        self.addSubview(addButton)
        self.addSubview(addButton_front)
        self.backgroundImage =  UIColor.creatImageWithColor(color: UIColor.white)
        self.shadowImage = UIImage.init()
        /// tabbar设置背景色
        //        self.shadowImage = UIImage()
//        self.backgroundImage = UIColor.creatImageWithColor(color: UIColor.black)
//        self.backgroundImage = UIImage(named: "test")
//        self.shadowImage = UIImage()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func addButtonClick(){
        if addDelegate != nil{
            addDelegate?.addClick()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let buttonX = self.frame.size.width/5
        var index = 0
        let label = UILabel(frame:CGRect(x:self.center.x - 15, y: self.frame.size.height/2 - 15, width:600.px(), height: 120.px()))
        let string = "AR探索"
        let ranStr = "AR探索"
        let attrstring : NSMutableAttributedString = NSMutableAttributedString(string: string)
        let str = NSString(string: string)
        let theRange = str.range(of: ranStr)
        label.textColor = UIColor.gray
 //       attrstring.addAttribute(kCTForegroundColorAttributeName as NSAttributedString.Key, value: UIColor.red, range: theRange)
        attrstring.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: UIFont.systemFont(ofSize: 18.px()), range: theRange)
        label.attributedText = attrstring
  //      self.addSubview(label)
        for barButton in self.subviews{
            
            if barButton.isKind(of: NSClassFromString("UITabBarButton")!){
                
                if index == 2{
                    /// 设置添加按钮位置
                    addButton.frame.size = CGSize.init(width: (addButton.currentBackgroundImage?.size.width)!, height: (addButton.currentBackgroundImage?.size.height)!)
                    addButton.center = CGPoint.init(x: self.center.x, y: self.frame.size.height/2 - 15)
                    addButton_front.frame.size = CGSize.init(width: (addButton_front.currentBackgroundImage?.size.width)!, height: (addButton_front.currentBackgroundImage?.size.height)!)
                    addButton_front.center = CGPoint.init(x: self.center.x, y: self.frame.size.height/2 - 15)
                    index += 1
                }
                barButton.frame = CGRect.init(x: buttonX * CGFloat(index), y: 0, width: buttonX, height: self.frame.size.height)
                index += 1
                
            }
        }
        self.bringSubviewToFront(addButton)
        self.bringSubviewToFront(addButton_front)
        self.addSubview(label)
    }
    
    /// 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        /// 判断是否为根控制器
        if self.isHidden {
            /// tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)
            
        }else{
            /// 将单钱触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.addButton_front)
            /// 判断新的点是否在按钮上
            if self.addButton_front.point(inside: onButton, with: event){
                return addButton_front
            }
            else{
                /// 不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }
    }
    
}

