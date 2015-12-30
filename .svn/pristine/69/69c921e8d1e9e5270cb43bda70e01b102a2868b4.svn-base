//
//  MagazineTableViewCell.m
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "MagazineTableViewCell.h"

@interface MagazineTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *topic_name;

@property (weak, nonatomic) IBOutlet UILabel *cat_name;

@end

@implementation MagazineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateWithModel:(WQQMagazineModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_img_new]];
    self.topic_name.text = model.topic_name;
    self.cat_name.text = [NSString stringWithFormat:@"#%@",model.cat_name];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
