//
//  MJYShareCommentTableViewCell.h
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJYUserModel.h"

@protocol MJYShareCommentTableViewCellDelegate <NSObject>

- (void)pushUpView:(MJYUserModel *)model;

@end

@interface MJYShareCommentTableViewCell : UITableViewCell

@property (nonatomic)id<MJYShareCommentTableViewCellDelegate>delegater;

@property (weak, nonatomic) IBOutlet UIImageView *HaedImageView;


@property (weak, nonatomic) IBOutlet UIButton *answerButton;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)updateWith:(MJYUserModel *)model;
+ (CGFloat)heightOfCellWithModel:(MJYUserModel*)model;
@end
