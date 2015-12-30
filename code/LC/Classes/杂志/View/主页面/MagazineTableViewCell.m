//
//  MagazineTableViewCell.m
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "MagazineTableViewCell.h"
#define LCRowHeight 210  // cell的高

@interface MagazineTableViewCell ()

@end

@implementation MagazineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateWithModel:(WQQMagazineModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_img_new] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.topic_name.text = model.topic_name;
    if (model.author_name.length > 0) {
        self.cat_name.text = [NSString stringWithFormat:@"#%@·%@",model.cat_name,model.author_name];
    }else {
        self.cat_name.text = [NSString stringWithFormat:@"#%@",model.cat_name];
    }
    [self setNeedsLayout];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
