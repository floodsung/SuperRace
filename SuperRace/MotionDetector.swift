//
//  MotionDetector.swift
//  SuperRace
//
//  Created by FloodSurge on 6/18/14.
//  Copyright (c) 2014 FloodSurge. All rights reserved.
//

import CoreMotion

class MotionDetector{
    
    let motionManager = CMMotionManager()
    var yaw = 0.0
    var timer:NSTimer? = nil
    
    
    class var sharedInstance:MotionDetector {
    struct Static {
        static var onceToken:dispatch_once_t = 0
        static var instance:MotionDetector? = nil
        }
        dispatch_once(&Static.onceToken){
            Static.instance = MotionDetector()
        }
        
        return Static.instance!
    }
    
    init(){
        motionManager.deviceMotionUpdateInterval = 0.01
    }
    
    func startMotionUpdate(){
        if motionManager.deviceMotionAvailable {
            if !motionManager.deviceMotionActive{
                motionManager.startDeviceMotionUpdates()
                println("Device Motion start update")
            }
        } else {
            println("Device Motion Unavailable!")
        }
    }
    
    func stopMotionUpdate(){
        if motionManager.deviceMotionAvailable {
            if !motionManager.deviceMotionActive{
                motionManager.stopDeviceMotionUpdates()
                println("Device Motion stop update")
            }
        } else {
            println("Device Motion Unavailable!")
        }
    }
    
    func startMotionDetect()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "motionDataAnalyse", userInfo: nil, repeats: true)
        
    }
    
    func stopMotionDetect()
    {
        timer!.invalidate()
    }
    
    func reset()
    {
        stopMotionDetect()
        stopMotionUpdate()
        startMotionUpdate()
        startMotionDetect()
    }
    
    func motionDataAnalyse()
    {
    
    }
    
}
