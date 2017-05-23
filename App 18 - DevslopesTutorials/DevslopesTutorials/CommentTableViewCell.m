//
//  CommentTableViewCell.m
//  DevslopesTutorials
//
//  Created by Per Kristensen on 22/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface CommentTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

@implementation CommentTableViewCell

- (void)configureUi:(NSString*)comment {
    self.commentLabel.text = comment;
}

@end
