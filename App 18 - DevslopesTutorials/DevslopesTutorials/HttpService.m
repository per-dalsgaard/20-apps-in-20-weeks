//
//  HttpService.m
//  DevslopesTutorials
//
//  Created by Per Kristensen on 13/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import "HttpService.h"

@implementation HttpService

+ (id)instance {
    static HttpService *sharedInstance = nil;
    
    @synchronized (self) {
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    }
    
    return sharedInstance;
}

@end
