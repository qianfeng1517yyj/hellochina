//
//  HeadCollectionReusableView.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "HeadCollectionReusableView.h"
#import "UIImageView+WebCache.h"
#import "TalentViewController.h"
#import "TalentShowViewController.h"

@implementation HeadCollectionReusableView

- (void)awakeFromNib {
    self.likeButton.titleEdgeInsets  = UIEdgeInsetsMake(30, 0, 30, 0);
    self.referButton.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 30, 0);
    self.focusButton.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 30, 0);
    self.fansButton.titleEdgeInsets  = UIEdgeInsetsMake(30, 0, 30, 0);
    // Initialization code
}
- (void)updateDataHeightWithModel:(TalentDetailModel*)model{
    
      [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.user_image] placeholderImage:[UIImage imageNamed:@"icn_11"]];
        self.nameLabel.text  = model.user_name;
        self.descLabel.text  = model.user_desc;
        self.likeLabel.text  = model.like_count;
        self.referLabel.text = model.recommendation_count;
        self.focusLabel.text = model.following_count;
        self.fansLabel.text  = model.followed_count;
}

- (IBAction)likeButtonClick:(id)sender {
    UIButton *button = (UIButton*)sender;
    
    if (self.tagBlock) {
        self.tagBlock(button.tag);
    }
}
- (IBAction)myFocusButton:(id)sender {
}

- (IBAction)myMessageButton:(id)sender {
}

@end
