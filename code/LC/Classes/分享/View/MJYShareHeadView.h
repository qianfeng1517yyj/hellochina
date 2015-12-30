//
//  MJYShareHeadView.h
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJYShareModel.h"
@protocol MJYShareHeadViewDelegate <NSObject>

- (void)pushViewWithUser:(MJYShareModel *)model;

@end
@interface MJYShareHeadView : UIView<UIScrollViewDelegate>

@property (nonatomic)MJYShareModel *model;

@property (nonatomic)UIPageControl *pageControl;

@property (nonatomic)id<MJYShareHeadViewDelegate>delegater;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *likeImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *owerImageView;

@property (weak, nonatomic) IBOutlet UILabel *owerNameLabel;

+ (CGFloat)heightForHeadViewWith:(MJYShareModel *)model;

@end
