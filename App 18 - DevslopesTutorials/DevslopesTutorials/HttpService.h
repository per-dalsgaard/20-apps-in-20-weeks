//
//  HttpService.h
//  DevslopesTutorials
//
//  Created by Per Kristensen on 13/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^onComplete)(NSArray * __nullable dataArray, NSString * __nullable errorMessage);

@interface HttpService : NSObject

+ (id)instance;
- (void)getTutorials:(nullable onComplete)completionHandler;
- (void)postComment:(NSString*)comment withUsername:(NSString*)username toVideo:(int)videoId completionHandler:(nullable onComplete)completionHandler;
- (void)getCommentsForVideo:(int)videoId completionHandler:(nullable onComplete)completionHandler;

@end
