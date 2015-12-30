//
//  GYDFourCollectionViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDFourCollectionViewCell.h"

@interface GYDFourCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic) GYDItemoModel *model;

@end

@implementation GYDFourCollectionViewCell

- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 20;
    self.iconView.layer.masksToBounds = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
    [self.iconView addGestureRecognizer:gesture];
}
- (void)imageClick {
    if (self.delegate != nil) {
        [self.delegate fourCollectionViewDidSelected:[self.model.brand_info  objectForKey:@"brand_id"]];
    }
}
- (void)layoutSubviews {
    CGRect rect = self.descLabel.frame;
    rect.origin.y = 50;
    rect.size.height = [GYDFourCollectionViewCell heightWithModel:self.model];
    self.descLabel.frame = rect;
    CGRect frame = self.frame;
    frame.size.height = rect.size.height + 120;
    self.frame = frame;
}
- (void)updateWithModel:(GYDItemoModel *)model {
    self.model = model;
    self.nameLabel.text = model.owner_name;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.owner_image]];
    NSDictionary *dic = model.good_guide;
    self.descLabel.text = [dic objectForKey:@"content"];
    self.titleLabel.text =  [NSString stringWithFormat:@"%@:",[dic objectForKey:@"title"]];
    [self setNeedsLayout];
}
+(CGFloat)heightWithBody:(NSString *)body {
    //计算字符串占用的大小
    CGRect rect = [body boundingRectWithSize:CGSizeMake(LCKScreenWidth-20, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height;
}
+ (CGFloat)heightWithModel:(GYDItemoModel *)model {
    CGFloat height = [self heightWithBody:model.rec_reason];
    return height + 200;
}
@end
