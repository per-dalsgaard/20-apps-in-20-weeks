//
//  ViewController.m
//  DevslopesTutorials
//
//  Created by Per Kristensen on 11/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import "ViewController.h"
#import "HttpService.h"
#import "VideoTableViewCell.h"
#import "Video.h"
#import "VideoViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *videoList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.videoList = [[NSArray alloc] init];
    
    [[HttpService instance] getTutorials:^(NSArray * _Nullable dataArray, NSString * _Nullable errorMessage) {
        if (dataArray) {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (NSDictionary *videoDict in dataArray) {
                Video *video = [[Video alloc] init];
                video.videoId = [[videoDict objectForKey:@"id"] intValue];
                video.videoTitle = [videoDict objectForKey:@"title"];
                video.videoDescription = [videoDict objectForKey:@"description"];
                video.videoIframe = [videoDict objectForKey:@"iframe"];
                video.thumbnailUrl =  [videoDict objectForKey:@"thumbnail"];
                
                NSArray *comments = [videoDict objectForKey:@"comments"];
                NSMutableArray *currentComments = [[NSMutableArray alloc] init];
                for (NSDictionary *commentDict in comments) {
                    NSString *comment = commentDict[@"comment"];
                    [currentComments addObject:comment];
                }
                video.comments = currentComments;
                
                [arr addObject:video];
            }
            
            self.videoList = arr;
            [self updateTableData];
            
        } else if (errorMessage) {
            NSLog(@"%@", errorMessage);
        }
    }];
}

- (void)updateTableData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    VideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    VideoTableViewCell *videoCell = (VideoTableViewCell*)cell;
    [videoCell updateUi:video];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Video *video = [self.videoList objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"VideoViewController" sender:video];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"VideoViewController"]) {
        VideoViewController *videoViewController = (VideoViewController*)segue.destinationViewController;
        videoViewController.video = (Video*)sender;
    }
}

@end
