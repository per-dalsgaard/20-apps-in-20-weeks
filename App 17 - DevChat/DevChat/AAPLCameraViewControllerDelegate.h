 //
//  AAPLCameraViewControllerDelegate.m
//  DevChat
//
//  Created by Per Kristensen on 02/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AAPLCameraViewControllerDelegate <NSObject>

-(void)shouldEnableRecordUI:(BOOL)enable;
-(void)shouldEnableCameraUI:(BOOL)enable;
-(void)canStartRecording;
-(void)recordingHasStarted;
-(void)videoRecordingComplete:(NSURL*)videoURL;
-(void)videoRecordingFailed;
-(void)snapshotTaken:(NSData*)snapshotData;
-(void)snapshotFailed;

@end
