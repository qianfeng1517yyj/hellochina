//
//  GYDThirdCollectionViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDThirdCollectionViewCell.h"

@interface GYDThirdCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic) GYDItemoModel *model;

@end

@implementation GYDThirdCollectionViewCell

- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 20;
    self.iconView.layer.masksToBounds = YES;
}
- (void)layoutSubviews {
    CGRect rect = self.descLabel.frame;
    rect.origin.y = 40;
    rect.size.height = [GYDThirdCollectionViewCell heightWithModel:self.model];
    self.descLabel.frame = rect;
    CGRect frame = self.frame;
    frame.size.height = rect.size.height + 80;
    self.frame = frame;
}
- (void)updateWithModel:(GYDItemoModel *)model {
    self.model = model;
    self.descLabel.text = model.rec_reason;
    [self setNeedsLayout];
}
+(CGFloat)heightWithBody:(NSString *)body {
    //计算字符串占用的大小
    CGRect rect = [body boundingRectWithSize:CGSizeMake(LCKScreenWidth-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height;
}
+ (CGFloat)heightWithModel:(GYDItemoModel *)model {
    CGFloat height = [self heightWithBody:model.rec_reason];
    return height + 80;
}
@end
