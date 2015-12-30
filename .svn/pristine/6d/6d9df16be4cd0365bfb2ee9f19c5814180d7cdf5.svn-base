//
//  GYDGoodViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDGoodViewCell.h"

@interface GYDGoodViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end
@implementation GYDGoodViewCell

- (void)awakeFromNib {
    
}
- (void)updateWithModel:(GYDGoodModel *)model {
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[model.images[0] objectForKey:@"url"]]];
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%ld",model.price];
    self.likeLabel.text = [NSString stringWithFormat:@"%ld",model.like_count];
}

@end
