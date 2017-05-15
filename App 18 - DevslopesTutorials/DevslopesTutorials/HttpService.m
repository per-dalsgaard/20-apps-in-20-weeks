//
//  HttpService.m
//  DevslopesTutorials
//
//  Created by Per Kristensen on 13/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import "HttpService.h"

#define URL_BASE "http://localhost:6069"
#define URL_TUTORIALS "/tutorials"

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

- (void)getTutorials:(nullable onComplete)completionHandler {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s%s", URL_BASE, URL_TUTORIALS]];
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (data != nil) {
            NSError *err;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            
            if (err == nil) {
                completionHandler(json, nil);
            } else {
                completionHandler(nil, @"Data is corrupt. Please try again!");
            }
        } else {
            completionHandler(nil, @"Problem connecting to the server");
        }
        
    }] resume];
}

@end
