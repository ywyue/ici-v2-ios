//
//  ViewController.swift
//  ici-v2
//
//  Created by Blanketzzz on 2018/9/25.
//  Copyright © 2018年 Blanketzzz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MAMapViewDelegate{
    
    let mapTitleImageView = UIImageView(image: UIImage(named: "mapTitle"))
    let mapTitleLabel = UILabel()
    let scoreTitleImageView = UIImageView(image: UIImage(named: "scoreTitle"))
    let scoreLabel = UILabel()
    let scoreImageView = UIImageView(image: UIImage(named: "score"))
    let verticalLineImageView = UIImageView(image: UIImage(named: "verticalLine"))
    let questionImageView = UIImageView(image: UIImage(named: "question"))
    
    class MAContentAnnotation: MAPointAnnotation{ //热门内容图标类（为了和自己的位置图标区分）
    }
    class MATopicAnnotation: MAPointAnnotation{ //热门话题图标类（为了和自己的位置图标区分）
    }
    class MAModelAnnotation: MAPointAnnotation{ //模型图标类（为了和自己的位置图标区分）
    }
    var topicPopupView: UIView! //热门话题弹窗视图
    var topicImageView: UIImageView! //热门话题图标
    var topicLabel: UILabel! //热门话题label
    var watchImageView: UIImageView! //围观图标
    var watchLabel: UILabel! //围观label
    var topicContentLabel: UILabel! //热门话题内容label
    
    var contentPopupView: UIView! //热门内容弹窗视图
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        /* 热门话题弹窗视图 */
      //  topicPopupView = UIView(frame:CGRect(x:self.view.frame.width/2-335.px(),y:self.view.frame.height-338.px(),width:670.px(),height:150.px()))
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
        
        let mapView = MAMapView(frame: self.view.bounds)
        var path = Bundle.main.bundlePath
        let contentAnnotation = MAContentAnnotation()
        let topicAnnotation = MATopicAnnotation()
        let modelAnnotation = MAModelAnnotation()
        path.append("/style.data")
        let jsonData = NSData.init(contentsOfFile: path)
        mapView.setCustomMapStyleWithWebData(jsonData as Data!)
        mapView.customMapStyleEnabled = true
        mapView.delegate = self as? MAMapViewDelegate
        
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
        
        mapTitleImageView.frame = CGRect(x:self.view.frame.width/2-105.px(),y:55.px(),width:210.px(),height:85.px())
        
        mapTitleLabel.frame = CGRect(x:mapTitleImageView.frame.width/2-40.px(),y:25.px(),width:80.px(),height:25.px())
        mapTitleLabel.textAlignment = .center
        mapTitleLabel.font = UIFont.boldSystemFont(ofSize:25.px())
        mapTitleLabel.text = "ici地图"
        mapTitleLabel.textColor = UIColor.black
        mapTitleImageView.addSubview(mapTitleLabel)
        mapView.addSubview(mapTitleImageView)
        
        scoreTitleImageView.frame = CGRect(x:mapTitleImageView.center.x-76.5.px(),y:145.px(),width:153.px(),height:60.px())
        scoreImageView.frame = CGRect(x:15.px(),y:10.px(),width:30.px(),height:30.px())
        verticalLineImageView.frame = CGRect(x:105.px(),y:12.5.px(),width:1.8.px(),height:25.px())
        questionImageView.frame = CGRect(x:115.px(),y:12.5.px(),width:25.px(),height:25.px())
        scoreLabel.frame = CGRect(x:scoreTitleImageView.frame.width/2-25.px(),y:14.px(),width:50.px(),height:20.px())
        scoreLabel.textAlignment = .left
        scoreLabel.font = UIFont.boldSystemFont(ofSize:20.px())

        scoreLabel.text = "400"
        scoreLabel.textColor = UIColor.black
        scoreTitleImageView.addSubview(scoreImageView)
        scoreTitleImageView.addSubview(scoreLabel)
        scoreTitleImageView.addSubview(verticalLineImageView)
        scoreTitleImageView.addSubview(questionImageView)
        mapView.addSubview(scoreTitleImageView)
        
        
        /*
        contentAnnotation.coordinate = CLLocationCoordinate2D(latitude: 30.529167, longitude: 114.355833)
        mapView.addAnnotation(contentAnnotation)
        
        topicAnnotation.coordinate = CLLocationCoordinate2D(latitude: 30.53993, longitude: 114.363939)
        mapView.addAnnotation(topicAnnotation)
        */
        modelAnnotation.coordinate = CLLocationCoordinate2D(latitude: 30.53993, longitude: 114.363939)
        mapView.addAnnotation(modelAnnotation)
        self.view.addSubview(mapView)
      //  self.view.addSubview(topicPopupView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
}

class MAModelCalloutView: UIView {
    let modelPopupImageView = UIImageView()
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
            let customView = MACustomCalloutView(frame:CGRect(x:0,y:0,width:670.px(),height:150.px()))
            customView.addSubview(topicPopupView)
            //设置弹窗和图标的相对位置，默认在正上方
            //annotationView!.calloutOffset = CGPoint(x:0,y:150.px())
            annotationView!.customCalloutView = customView
            annotationView!.canShowCallout = true
            
            return annotationView!
        }
        
        return nil
    }
   
    

    
}


