//
//  MotionDetector.swift
//  SuperRace
//
//  Created by FloodSurge on 6/18/14.
//  Copyright (c) 2014 FloodSurge. All rights reserved.
//

import CoreMotion

let instance = MotionDetector()

class MotionDetector{
    
    let motionManager = CMMotionManager()
    
    class var sharedInstance:MotionDetector {
    return instance
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
    
    
}
