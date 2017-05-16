//
//  Video.h
//  DevslopesTutorials
//
//  Created by Per Kristensen on 16/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoDescription;
@property (nonatomic, strong) NSString *videoIframe;
@property (nonatomic, strong) NSString *thumbnailUrl;

@end
