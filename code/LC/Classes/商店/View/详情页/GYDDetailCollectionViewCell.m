//
//  GYDDetailCollectionViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDDetailCollectionViewCell.h"

@interface GYDDetailCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@property (nonatomic) GYDStoreDetailModel *model;



@end

@implementation GYDDetailCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)udpateWithModel:(GYDStoreDetailModel *)model {
    self.model = model;
    if (!model.is_gift) {
        self.giftImageView.hidden = YES;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    self.nameLabel.text = model.goods_name;
    self.brandNameLabel.text = [model.brand_info objectForKey:@"brand_name"];
    self.likeCountLabel.text = model.like_count;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
}

@end
