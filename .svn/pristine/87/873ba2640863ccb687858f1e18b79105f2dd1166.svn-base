//
//  HeadCollectionReusableView.h
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalentShowModel.h"
#import "TalentDetailModel.h"
typedef void(^BtnClickBlock)(NSInteger tag);

@interface HeadCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *referButton;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
@property (weak, nonatomic) IBOutlet UIButton *fansButton;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *referLabel;
@property (weak, nonatomic) IBOutlet UILabel *focusLabel;

@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property(nonatomic,copy)BtnClickBlock  tagBlock;

- (void)updateDataHeightWithModel:(TalentDetailModel*)model;
@end
