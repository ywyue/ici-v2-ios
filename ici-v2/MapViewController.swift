//
//  ViewController.swift
//  map-test
//
//  Created by Blanketzzz on 2018/9/25.
//  Copyright © 2018年 Blanketzzz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MAMapViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = "地图"
//        self.tabBarItem.image = UIImage(named: "MapIcon")?.withRenderingMode(.alwaysOriginal)
        
        let mapView = MAMapView(frame: self.view.bounds)
        var path = Bundle.main.bundlePath
        let pointAnnotation = MAPointAnnotation()
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
        
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 30.529167, longitude: 114.355833)
        mapView.addAnnotation(pointAnnotation)
        
        self.view.addSubview(mapView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

extension MapViewController {
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "item"
            var annotationView: MAAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier)
            
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            annotationView!.annotation = annotation
            annotationView!.image = UIImage(named: "message")
            //设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView!.centerOffset = CGPoint(x:0, y:-18);
            
            return annotationView!
        }
        
        return nil
    }
}



