//
//  MTLSampleMasterCellViewCell.m
//  pintarest
//
//  Created by Funami Takao on 12/02/24.
//  Copyright (c) 2012年 Recruit. All rights reserved.
//

#import "MTLSampleMasterCellViewCell.h"

@implementation MTLSampleMasterCellViewCell
@synthesize userImageView;
@synthesize userName;
@synthesize title;
@synthesize key = _key;
@synthesize progress = _progress;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.imageView setImage:nil];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
