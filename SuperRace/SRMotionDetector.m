//
//  SRHitDetector.m
//  HeadHit
//
//  Created by Rotek on 3/7/13.
//  Copyright (c) 2013 Rotek. All rights reserved.
//

#import "SRMotionDetector.h"
#import "SRMath.h"
  
@interface SRMotionDetector ()

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation SRMotionDetector

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    static SRMotionDetector *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


#pragma mark - Private Methods

- (id)init
{
    if (self = [super init]) {
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = 0.01f;
    }
    
    return self;
}

- (void)startUpdate
{
    NSLog(@"start update");
    if (self.motionManager.isDeviceMotionAvailable) {
        if (!self.motionManager.isDeviceMotionActive) {
            [self.motionManager startDeviceMotionUpdates];

            NSLog(@"Start device motion");
        }
    } else NSLog(@"Device motion unavailable");
    
}

- (void)stopUpdate
{
    NSLog(@"stopUpdate");
    if (self.motionManager.isDeviceMotionAvailable) {
        if (self.motionManager.isDeviceMotionActive) {
            [self.motionManager stopDeviceMotionUpdates];
            NSLog(@"Stop device motion");
        }
    } else NSLog(@"Device motion unavailable");
}

- (void)startDetect
{
        
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(dataAnalyse) userInfo:nil repeats:YES];

}

- (void)stopDetect
{
    [self.timer invalidate];
}

- (void)reset
{
    [self stopDetect];
    [self stopUpdate];
    [self startUpdate];
    [self startDetect];
}

- (void)dataAnalyse
{
    //float _currentDegree = [self calculateCurrentDegree];
    
    self.yaw = self.motionManager.deviceMotion.attitude.yaw;
}
- (double)rotationDegree
{
    return self.motionManager.deviceMotion.attitude.yaw;
}

- (float)calculateCurrentDegree
{
    GLKQuaternion currentAttitude = GLKQuaternionMake(self.motionManager.deviceMotion.attitude.quaternion.x, self.motionManager.deviceMotion.attitude.quaternion.y, self.motionManager.deviceMotion.attitude.quaternion.z, self.motionManager.deviceMotion.attitude.quaternion.w);
    
    GLKVector3 initVector = GLKVector3Make(0, 0, 1);
    GLKVector3 currentVector = GLKQuaternionRotateVector3(currentAttitude, initVector);
    
    GLKVector3 gravity = GLKVector3Make(0, 0, -1);
    
    GLKQuaternion delta = [SRMath createFromVector0:currentVector vector1:gravity];
    float degree = GLKQuaternionAngle(delta) * 180.0 / M_PI;
    
    
    return degree;
    
}

@end
