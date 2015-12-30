//
//  GYDFourCollectionViewCell.h
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYDItemoModel.h"

@protocol GYDFourCollectionViewCellDelegate <NSObject>

- (void)fourCollectionViewDidSelected:(NSString *)model_id;

@end

@interface GYDFourCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<GYDFourCollectionViewCellDelegate> delegate;

- (void)updateWithModel:(GYDItemoModel *)model;
+ (CGFloat)heightWithModel:(GYDItemoModel *)model;

@end
