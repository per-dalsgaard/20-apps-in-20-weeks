//
//  VideoTableViewCell.m
//  DevslopesTutorials
//
//  Created by Per Kristensen on 15/05/2017.
//  Copyright © 2017 Per Dalsgaard. All rights reserved.
//

#import "VideoTableViewCell.h"

@interface VideoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (weak, nonatomic) IBOutlet UIView *cellView;

@end


@implementation VideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


    self.layer.cornerRadius = 2.0;
    self.layer.shadowColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:0.8].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowRadius = 5.0;
    self.layer.shadowOffset = CGSizeMake(0.0, 2.0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
