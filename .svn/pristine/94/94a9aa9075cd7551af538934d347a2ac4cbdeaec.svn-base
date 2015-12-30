//
//  GYDSecondCollectionViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDSecondCollectionViewCell.h"

@interface GYDSecondCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodDescLabel;

@property (nonatomic) GYDItemoModel *model;
@end

@implementation GYDSecondCollectionViewCell

- (void)awakeFromNib {
    
}
- (void)layoutSubviews {
    CGRect rect = self.goodDescLabel.frame;
    rect.size.height = [GYDSecondCollectionViewCell heightWithBody:self.goodDescLabel.text];
    self.goodDescLabel.frame = rect;
    CGRect frame = self.frame;
    frame.size.height = rect.size.height + 75;
    self.frame = frame;
}

- (void)updateWithModel:(GYDItemoModel *)model {
    self.model = model;
    self.brandNameLabel.text = model.owner_name;
    self.goodNameLabel.text = model.goods_name;
    self.goodDescLabel.text = model.goods_desc;
    [self setNeedsLayout];
}

+(CGFloat)heightWithBody:(NSString *)body {
    //计算字符串占用的大小
    CGRect rect = [body boundingRectWithSize:CGSizeMake(LCKScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height;
}
+ (CGFloat)heightWithModel:(GYDItemoModel *)model {
    CGFloat height = [self heightWithBody:model.goods_desc];
    return height + 75;
}



@end
