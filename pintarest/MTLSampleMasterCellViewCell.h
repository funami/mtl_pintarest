//
//  MTLSampleMasterCellViewCell.h
//  pintarest
//
//  Created by Funami Takao on 12/02/24.
//  Copyright (c) 2012年 Recruit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTLSampleMasterCellViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;

@property (strong, nonatomic) NSString *key;
@end
