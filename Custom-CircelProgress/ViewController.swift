//
//  ViewController.swift
//  Custom-CircelProgress
//
//  Created by M Akbari on 4/3/1398 AP.
//  Copyright © 1398 M Akbari. All rights reserved.
//

import UIKit


class ViewController: UIViewController ,URLSessionDownloadDelegate{
   
    

    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var plusingLayer:CAShapeLayer!
    
    let labelPresntage:UILabel = {
        let label = UILabel()
        label.text = "Strat"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        

    }
    
    private func setupView() {
        view.backgroundColor = .black
        
      //  let center = view.center
        
        
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        //MARK:- pulsing
        plusingLayer = CAShapeLayer()
        plusingLayer.path = circularPath.cgPath
        plusingLayer.strokeColor = UIColor.clear.cgColor
        plusingLayer.lineWidth = 10
        plusingLayer.lineCap = .round
        plusingLayer.fillColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        plusingLayer.position = view.center
        view.layer.addSublayer(plusingLayer)
        
        //MARK:- TRACK
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        trackLayer.lineWidth = 20
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.black.cgColor
        trackLayer.position = view.center
        view.layer.addSublayer(trackLayer)
        
        
        animatePlusingLayer()
        //MARK: - shape
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = #colorLiteral(red: 0.8956445446, green: 0.03083319551, blue: 0.3762170692, alpha: 1)
        shapeLayer.lineWidth = 20
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.position = view.center
        view.layer.addSublayer(shapeLayer)
        

        //MARK: - Circel Difrent positoin on track
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)

        view.layer.addSublayer(shapeLayer)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelTab)))
        
        view.addSubview(labelPresntage)
        labelPresntage.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        labelPresntage.center = view.center
        
    }
    
    private func animatePlusingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        plusingLayer.add(animation, forKey: "pulsing")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    let urlString = "https://hw14.cdn.asset.aparat.com/aparat-video/233242ee03a74cdf7189ce63dfae4b9015571712-720p__97430.mp4"
    
    private func beginDownloadFile() {
        
        shapeLayer.strokeEnd = 0
        
        let configration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSection = URLSession(configuration: configration, delegate: self, delegateQueue: operationQueue)
        guard let url = URL(string: urlString) else {return}
        let downloadTask = urlSection.downloadTask(with: url)
        downloadTask.resume()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("finished")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        let persent = Int(percentage * 100)
        DispatchQueue.main.async {
            self.labelPresntage.text = "\(persent)%"
            if persent == 100 {
                self.labelPresntage.text = "Complate"
                self.labelPresntage.font = .boldSystemFont(ofSize: 14)
            }
            
            self.shapeLayer.strokeEnd = percentage
        }
    }
    
    fileprivate func circelAnimat() {
        let basicAnimations = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimations.toValue = 1
        basicAnimations.duration = 2
        basicAnimations.fillMode = .forwards
        basicAnimations.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimations, forKey: "urSoBasic")
    }
    
    @objc private func handelTab() {
       // circelAnimat()
        beginDownloadFile()
        
    }


}

