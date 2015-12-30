//
//  GYDDetailHeadView.h
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreItemModel.h"

@protocol GYDDetailHeadViewDelegate <NSObject>

- (void)detailHeadViewDidSelected:(StoreItemModel *)model;

- (void)detailHeadViewPriceSelected:(NSString *)price;

@end

@interface GYDDetailHeadView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *lineView;

@property (weak, nonatomic) IBOutlet UIButton *nameButton;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (nonatomic) StoreItemModel *superModel;
@property (nonatomic, weak) UIView *bgView;

@property (nonatomic, weak) id<GYDDetailHeadViewDelegate> delegate;

- (void)udpateWithModel:(StoreItemModel *)model;


@end
