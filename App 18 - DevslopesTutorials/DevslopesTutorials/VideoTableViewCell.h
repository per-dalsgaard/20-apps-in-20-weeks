//
//  VideoTableViewCell.h
//  DevslopesTutorials
//
//  Created by Per Kristensen on 15/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Video;

@interface VideoTableViewCell : UITableViewCell

- (void)updateUi:(nonnull Video*)video;

@end
