//
//  WQQAuthorTableViewCell.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "WQQAuthorTableViewCell.h"

@interface WQQAuthorTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailNameLabel;


@end

@implementation WQQAuthorTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateWithModel:(WQQAuthorModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.titleNameLabel.text = model.author_name;
    self.detailNameLabel.text = model.note;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
