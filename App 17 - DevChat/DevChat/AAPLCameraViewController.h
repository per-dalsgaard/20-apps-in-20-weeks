/*
Copyright (C) 2015 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
View controller for camera interface.
*/

#import "AAPLCameraViewControllerDelegate.h"

@import UIKit;
@class AAPLPreviewView;
@protocol AAPLCameraViewControllerDelegate;

@interface AAPLCameraViewController : UIViewController
@property (nonatomic, weak) AAPLPreviewView *_previewView;
@property (retain) id <AAPLCameraViewControllerDelegate> delegate;

- (void)changeCamera;
- (void)toggleMovieRecording;

@end
