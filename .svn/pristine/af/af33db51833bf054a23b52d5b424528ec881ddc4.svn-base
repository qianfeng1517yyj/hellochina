//
//  GYDGoodHeadView.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDGoodHeadView.h"

@interface GYDGoodHeadView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end
@implementation GYDGoodHeadView

- (void)awakeFromNib {
    // Initialization code
}
- (void)udpateWithDic:(NSDictionary *)dic {
    self.nameLabel.text = [dic objectForKey:@"name"];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"url"]]];
}

@end
