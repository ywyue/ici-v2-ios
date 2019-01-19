//
//  ViewController.swift
//  ici-v2
//
//  Created by Blanketzzz on 2018/9/25.
//  Copyright © 2018年 Blanketzzz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MAMapViewDelegate, AMapSearchDelegate{
    
    var mapTitleImageView:UIImageView! //地图上方标题背景图片
    var mapTitleLabel:UILabel! //地图标题
    var scoreTitleImageView:UIImageView! //个人积分背景图片
    var scoreLabel:UILabel! //个人积分
    var scoreImageView:UIImageView! //积分图片
    var verticalLineImageView:UIImageView! //垂直线
    var questionImageView:UIImageView! //问题图标
    
    class MAContentAnnotation: MAPointAnnotation{ //热门内容图标类（为了和自己的位置图标区分）
    }
    class MATopicAnnotation: MAPointAnnotation{ //热门话题图标类（为了和自己的位置图标区分）
    }
    class MAModelAnnotation: MAPointAnnotation{ //模型图标类（为了和自己的位置图标区分）
    }
    var modelPopupView: UIView! //模型图标弹窗视图
    var topicPopupView: UIView! //热门话题弹窗视图
    var topicImageView: UIImageView! //热门话题图标
    var topicLabel: UILabel! //热门话题label
    var watchImageView: UIImageView! //围观图标
    var watchLabel: UILabel! //围观label
    var topicContentLabel: UILabel! //热门话题内容label
    
    var contentPopupView: UIView! //热门内容弹窗视图
    
    
    var mapView: MAMapView!         //地图
    var search: AMapSearchAPI!      // 地图内的搜索API类
    var route: AMapRoute!           //路径规划信息
    
    var startAnnotation: MAPointAnnotation!
    var destinationAnnotation: MAPointAnnotation!
    
    var startCoordinate: CLLocationCoordinate2D! //起始点经纬度
    var destinationCoordinate: CLLocationCoordinate2D! //终点经纬度
    
    var totalRouteNums: NSInteger!  //总共规划的线路的条数
    var currentRouteIndex: NSInteger!   //当前显示线路的索引值，从0开始
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        /* 热门话题弹窗视图 */
        topicPopupView = UIView(frame:CGRect(x:0,y:0,width:670.px(),height:150.px()))
        topicPopupView.backgroundColor = UIColor(patternImage: UIImage(named: "topicPopup")!)
        
        /* 热门话题图标 */
        topicImageView = UIImageView(image: UIImage(named: "bulb"))
        topicImageView.frame = CGRect(x:33.px(),y:20.px(),width:96.px(),height:96.px())
        topicPopupView.addSubview(topicImageView)
        
        /* 热门话题label */
        topicLabel = UILabel()
        topicLabel.frame = CGRect(x:162.px(),y:35.px(),width:150.px(),height:30.px())
        topicLabel.textAlignment = .left
        topicLabel.font = UIFont.boldSystemFont(ofSize:30.px())
        topicLabel.text = "热门话题"
        topicLabel.textColor = UIColor.black
        topicPopupView.addSubview(topicLabel)
        
        /* 热门话题内容label */
        topicContentLabel = UILabel()
        topicContentLabel.frame = CGRect(x:162.px(),y:79.px(),width:300.px(),height:25.px())
        topicContentLabel.textAlignment = .left
        topicContentLabel.font = UIFont.boldSystemFont(ofSize:25.px())
        topicContentLabel.text = "这里会举行金秋艺术节"
        topicContentLabel.textColor = UIColor.gray
        topicPopupView.addSubview(topicContentLabel)
        
        /* 围观图标 */
        watchImageView = UIImageView(image: UIImage(named: "watchBtn"))
        watchImageView.frame = CGRect(x:490.px(),y:39.px(),width:130.px(),height:60.px())
        
        /* 围观label */
        watchLabel = UILabel()
        watchLabel.frame = CGRect(x:watchImageView.frame.width/2-32.5.px(),y:watchImageView.frame.height/2-15.px(),width:65.px(),height:30.px())
        watchLabel.textAlignment = .center
        watchLabel.font = UIFont.boldSystemFont(ofSize:30.px())
        watchLabel.text = "围观"
        watchLabel.textColor = UIColor.black
        watchImageView.addSubview(watchLabel)
        topicPopupView.addSubview(watchImageView)
        
        
        
        
//        self.title = "地图"
//        self.tabBarItem.image = UIImage(named: "MapIcon")?.withRenderingMode(.alwaysOriginal)
        
        
        initMapViewAndSearch()
        initMapTitleAndScore()
        addModelAnnotations()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    //初始化地图,和搜索API
    func initMapViewAndSearch() {
        
        mapView = MAMapView(frame: self.view.bounds)
        var path = Bundle.main.bundlePath
        //      let contentAnnotation = MAContentAnnotation()
        //      let topicAnnotation = MATopicAnnotation()
        path.append("/style.data")
        let jsonData = NSData.init(contentsOfFile: path)
        mapView.setCustomMapStyleWithWebData(jsonData as Data!)
        mapView.customMapStyleEnabled = true
        mapView.delegate = self
        
        AMapServices.shared()?.enableHTTPS = true
        
        let r = MAUserLocationRepresentation()
        r.showsHeadingIndicator = false
        r.showsAccuracyRing = false
        r.locationDotFillColor = UIColor(red: 200/255, green: 94/255, blue: 104/255, alpha: 1)
        mapView.update(r)
        mapView.showsUserLocation = true
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.setCameraDegree(0, animated: true, duration: 0.5)
        mapView.userTrackingMode = .follow
        mapView.setZoomLevel(17.5, animated: true)
        
        self.view.addSubview(mapView)
        
        self.search = AMapSearchAPI()
        self.search.delegate = self
    }
    
    //初始化地图界面上方标题和个人积分
    func initMapTitleAndScore() {
        
        mapTitleImageView = UIImageView(image: UIImage(named: "mapTitle"))
        mapTitleImageView.frame = CGRect(x:self.view.frame.width/2-105.px(),y:55.px(),width:210.px(),height:85.px())
        mapTitleLabel = UILabel()
        mapTitleLabel.frame = CGRect(x:mapTitleImageView.frame.width/2-40.px(),y:25.px(),width:80.px(),height:25.px())
        mapTitleLabel.textAlignment = .center
        mapTitleLabel.font = UIFont.boldSystemFont(ofSize:25.px())
        mapTitleLabel.text = "ici地图"
        mapTitleLabel.textColor = UIColor.black
        mapTitleImageView.addSubview(mapTitleLabel)
        
        scoreTitleImageView = UIImageView(image: UIImage(named: "scoreTitle"))
        scoreTitleImageView.frame = CGRect(x:mapTitleImageView.center.x-76.5.px(),y:145.px(),width:153.px(),height:60.px())
        
        scoreImageView = UIImageView(image: UIImage(named: "score"))
        scoreImageView.frame = CGRect(x:15.px(),y:10.px(),width:30.px(),height:30.px())
        
        verticalLineImageView = UIImageView(image: UIImage(named: "verticalLine"))
        verticalLineImageView.frame = CGRect(x:105.px(),y:12.5.px(),width:1.8.px(),height:25.px())
        
        questionImageView = UIImageView(image: UIImage(named: "question"))
        questionImageView.frame = CGRect(x:115.px(),y:12.5.px(),width:25.px(),height:25.px())
        
        scoreLabel = UILabel()
        scoreLabel.frame = CGRect(x:scoreTitleImageView.frame.width/2-25.px(),y:14.px(),width:50.px(),height:20.px())
        scoreLabel.textAlignment = .left
        scoreLabel.font = UIFont.boldSystemFont(ofSize:20.px())
        scoreLabel.text = "400"
        scoreLabel.textColor = UIColor.black
        
        scoreTitleImageView.addSubview(scoreImageView)
        scoreTitleImageView.addSubview(scoreLabel)
        scoreTitleImageView.addSubview(verticalLineImageView)
        scoreTitleImageView.addSubview(questionImageView)
        
        self.view.addSubview(mapTitleImageView)
        self.view.addSubview(scoreTitleImageView)
    }
    
    func addModelAnnotations() {
        let modelAnnotation = MAModelAnnotation()
        modelAnnotation.coordinate = CLLocationCoordinate2D(latitude: 30.53993, longitude: 114.363939)
        mapView.addAnnotation(modelAnnotation)
    }
    
    @objc func exploreBtnViewClicked(){
        print("***************")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
}


extension MapViewController {
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if (annotation is MAContentAnnotation) {  //判断是否为热门内容点
            let pointReuseIndetifier = "contentMarker"
            var annotationView: MAAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier)
            
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            annotationView!.annotation = annotation
            annotationView!.image = UIImage(named: "contentMarker")
            annotationView!.frame = CGRect(x:0,y:0,width:88.px(),height:88.px())
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView!.centerOffset = CGPoint(x:0, y:-44.px());
            return annotationView!
        }
        else if (annotation is MATopicAnnotation) {  //判断是否为热门话题点
            let pointReuseIndetifier = "topicMarker"
            var annotationView: MAAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier)
            
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            annotationView!.annotation = annotation
            
            annotationView!.image = UIImage(named: "topicMarker")
            annotationView!.frame = CGRect(x:0,y:0,width:88.px(),height:88.px())
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView!.centerOffset = CGPoint(x:0, y:-44.px());
            let customView = MACustomCalloutView(frame:CGRect(x:0,y:0,width:670.px(),height:150.px()))
            customView.addSubview(topicPopupView)
            //设置弹窗和图标的相对位置，默认在正上方
            //annotationView!.calloutOffset = CGPoint(x:0,y:150.px())
            annotationView!.customCalloutView = customView
            annotationView!.canShowCallout = true
            
            return annotationView!
        }
        else if (annotation is MAModelAnnotation) {  //判断是否为热门话题点
            let pointReuseIndetifier = "modelMarker"
            var annotationView: MAAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier)
            
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            annotationView!.annotation = annotation
            
            annotationView!.image = UIImage(named: "modelMarker")
            annotationView!.frame = CGRect(x:0,y:0,width:88.px(),height:88.px())
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView!.centerOffset = CGPoint(x:0, y:-44.px());
            
            //创建自定义弹窗
            let customView = MACustomCalloutView(frame:CGRect(x:0,y:0,width:275.px(),height:135.px()))
            
            /* 模型图标弹窗视图 */
            modelPopupView = UIView(frame:CGRect(x:0,y:0,width:275.px(),height:135.px()))
            modelPopupView.backgroundColor = UIColor(patternImage: UIImage(named: "modelPopup")!)
            
            /* 模型图标弹窗视图label */
            let modelPopupViewLabel = UILabel()
            modelPopupViewLabel.frame = CGRect(x:26.px(),y:21.px(),width:220.px(),height:20.px())
            modelPopupViewLabel.textAlignment = .left
            modelPopupViewLabel.font = UIFont.boldSystemFont(ofSize:20.px())
            modelPopupViewLabel.text = "有人在此地发了一条ici"
            modelPopupViewLabel.textColor = UIColor.black
            modelPopupView.addSubview(modelPopupViewLabel)
            
            /* 模型图标弹窗视图探索按钮背景 */
            let exploreBtnView = UIImageView(image: UIImage(named: "exploreBtn"))
            exploreBtnView.frame = CGRect(x:91.px(),y:60.px(),width:84.px(),height:35.px())
            modelPopupView.addSubview(exploreBtnView)
            exploreBtnView.isUserInteractionEnabled = true
            let exploreBtnViewClickGesture = UITapGestureRecognizer(target: self, action: #selector(self.exploreBtnViewClicked))
            exploreBtnView.addGestureRecognizer(exploreBtnViewClickGesture)
            
            /* 模型图标弹窗视图探索按钮label */
            let exploreBtnViewLabel = UILabel()
            exploreBtnViewLabel.frame = CGRect(x:113.px(),y:67.px(),width:50.px(),height:20.px())
            exploreBtnViewLabel.textAlignment = .left
            exploreBtnViewLabel.font = UIFont.boldSystemFont(ofSize:20.px())
            exploreBtnViewLabel.text = "探索"
            exploreBtnViewLabel.textColor = UIColor.white
            modelPopupView.addSubview(exploreBtnViewLabel)
            
            customView.addSubview(modelPopupView)
            //设置弹窗和图标的相对位置，默认在正上方
            //annotationView!.calloutOffset = CGPoint(x:0,y:150.px())
            annotationView!.customCalloutView = customView
            annotationView!.canShowCallout = true
            
            return annotationView!
        }
        
        return nil
    }
   
    

    
}


