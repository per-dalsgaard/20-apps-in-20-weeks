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
#import "CommentTableViewCell.h"

@interface VideoViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    [[HttpService instance] postComment:comment withUsername:username toVideo:self.video.videoId completionHandler:^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
        if (dataArray) {
            BOOL success = [[dataArray firstObject] boolValue];
            if (success) {
                [[HttpService instance] getCommentsForVideo:self.video.videoId completionHandler:^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
                    if (dataArray) {
                        NSMutableArray *comments = [[NSMutableArray alloc] init];
                        for (NSDictionary *commentDict in dataArray) {
                            [comments addObject:commentDict[@"comment"]];
                        }
                        self.video.comments = comments;
                        self.commentTextView.text = @"";
                        [self updateTableData];
                    } else {
                        NSLog(@"%@", errorMessage);
                    }
                }];
            } else {
                NSLog(@"Ewww :-(");
            }
        } else {
            NSLog(@"%@", errorMessage);
        }
    }];
}

- (void)updateTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.video.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell" forIndexPath:indexPath];
    NSString *comment = [self.video.comments objectAtIndex:indexPath.row];
    [cell configureUi:comment];
    return cell;
}

@end
