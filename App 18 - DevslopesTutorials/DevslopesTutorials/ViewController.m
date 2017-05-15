//
//  ViewController.m
//  DevslopesTutorials
//
//  Created by Per Kristensen on 11/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import "ViewController.h"
#import "HttpService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[HttpService instance] getTutorials:^(NSDictionary * _Nullable dataDict, NSString * _Nullable errorMessage) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
