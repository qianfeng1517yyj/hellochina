//
//  GYDStoreHeadView.h
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreHeadModel;
@protocol GYDStoreHeadViewDlegate <NSObject>

- (void)headViewDidSelected:(StoreHeadModel *)model tag:(NSInteger)tag;

@end

@interface GYDStoreHeadView : UIView

@property (nonatomic, weak) id<GYDStoreHeadViewDlegate> delegate;

- (void)updateWithArray:(NSArray *)arr;

@end
