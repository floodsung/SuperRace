//
//  SRHitDetector.h
//  HeadHit
//
//  Created by Rotek on 3/7/13.
//  Copyright (c) 2013 Rotek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
@interface SRMotionDetector : NSObject

+ (id)sharedInstance;

@property (nonatomic,assign) double yaw;
@property (nonatomic,strong) CMMotionManager *motionManager;

- (void)reset;
- (void)startUpdate;
- (void)stopUpdate;
- (void)startDetect;
- (void)stopDetect;
- (double)rotationDegree;


@end
