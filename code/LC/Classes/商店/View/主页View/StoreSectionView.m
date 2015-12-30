//
//  StoreSectionView.m
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "StoreSectionView.h"


@interface StoreSectionView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation StoreSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"StoreSectionView" owner:nil options:nil] lastObject];
        [self addTapGestureRecognizer];
    }
    return self;
}
- (void)addTapGestureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(handleTapGesture:)];
    [self addGestureRecognizer:tap];
}

- (void)handleTapGesture:(UITapGestureRecognizer*)gesture
{
    if(self.block)
    {
        self.block(self.tag);
    }
}

- (void)updateWithModel:(StoreItemModel *)model {
    NSString *iconUrlStr = [model.cover objectForKey:@"url"];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:iconUrlStr] placeholderImage:[UIImage imageNamed:@"storePlace"]];
}

- (void)setFrame:(CGRect)frame{
    CGRect sectionRect = [self.tableView rectForSection:self.section];
    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame)); [super setFrame:newFrame];
}


@end
