//
//  VideoViewController.h
//  DevslopesTutorials
//
//  Created by Per Kristensen on 17/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Video;

@interface VideoViewController : UIViewController <UIWebViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Video *video;

@end
