//
//  VideoViewController.m
//  DevslopesTutorials
//
//  Created by Per Kristensen on 17/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import "VideoViewController.h"
#import "Video.h"
#import "HttpService.h"

@interface VideoViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.video.videoTitle;
    self.descriptionLabel.text = self.video.videoDescription;
    self.webView.delegate = self;
    
    [self.webView loadHTMLString:self.video.videoIframe baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *css = @".container {position: relative; width: 100%; height: 0; padding-bottom: 56.25%;} .video {position: absolute; top: 0; left: 0; width: 100%; height: 100%;}";
    
    NSString* js = [NSString stringWithFormat:
                    @"var styleNode = document.createElement('style');\n"
                    "styleNode.type = \"text/css\";\n"
                    "var styleText = document.createTextNode('%@');\n"
                    "styleNode.appendChild(styleText);\n"
                    "document.getElementsByTagName('head')[0].appendChild(styleNode);\n",css];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}
- (IBAction)postCommentButtonPressed:(id)sender {
    NSString *comment = self.commentTextView.text;
    NSString *username = @"PEDK"; // TODO
    [[HttpService instance] postComment:comment withUsername:username completionHandler:^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
        if (dataArray) {
            BOOL success = [[dataArray firstObject] boolValue];
            if (success) {
                NSLog(@"Comment saved");
            } else {
                NSLog(@"Der skete en fejl!!!");
            }
        }
    }];
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
