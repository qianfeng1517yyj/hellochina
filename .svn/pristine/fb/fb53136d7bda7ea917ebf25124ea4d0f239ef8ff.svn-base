//
//  GYDShopViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDShopViewCell.h"

@interface GYDShopViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation GYDShopViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)updateWithModel:(GYDShopModel *)model {
    self.descLabel.text = model.description;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[model.logo objectForKey:@"url"]]];
}

@end
