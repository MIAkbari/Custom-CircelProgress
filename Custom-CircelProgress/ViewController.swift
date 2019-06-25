//
//  ViewController.swift
//  Custom-CircelProgress
//
//  Created by M Akbari on 4/3/1398 AP.
//  Copyright © 1398 M Akbari. All rights reserved.
//

import UIKit


class ViewController: UIViewController ,URLSessionDownloadDelegate{
   

    let circle = MICircle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelTab)))
        view.addSubview(circle)
        circle.center = view.center
        circle.animatePulsingLayer(true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    let urlString = "https://hw14.cdn.asset.aparat.com/aparat-video/233242ee03a74cdf7189ce63dfae4b9015571712-720p__97430.mp4"
    
    private func beginDownloadFile() {
        
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
            self.circle.labelPresntage.text = "\(persent)%"
            if persent == 100 {
                self.circle.labelPresntage.text = "Complate"
                self.circle.labelPresntage.font = .boldSystemFont(ofSize: 16)
            }
            
            self.circle.shapeLayer.strokeEnd = percentage
        }
    }
    
    
    @objc private func handelTab() {
        beginDownloadFile()
    }
  

}


