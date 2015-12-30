//
//  WQQCategoryCollectionViewCell.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "WQQCategoryCollectionViewCell.h"

@interface WQQCategoryCollectionViewCell ()



@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end

@implementation WQQCategoryCollectionViewCell

- (void)awakeFromNib {
}


- (void)updateWithModel:(WQQCategory *)model {
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.titleNameLabel.text = model.cat_name;
    [self setNeedsLayout];
}

- (void)updateWithModel2:(WQQCategory *)model index:(NSInteger)index{
    if (index == 0) {
        self.iconImageView.image = [UIImage imageNamed:@"uncollected_spec@2x.png"];
    }
    if (index == 1) {
        self.iconImageView.image = [UIImage imageNamed:@"spec_all_icon@2x.png"];
    }
    self.bgImageView.image = [UIImage imageNamed:model.thumb];
    self.titleNameLabel.text = model.cat_name;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.isSelected) {
        self.layer.borderWidth = 5;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}


@end
