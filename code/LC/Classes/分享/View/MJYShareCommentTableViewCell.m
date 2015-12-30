//
//  MJYShareCommentTableViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "MJYShareCommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "TalentViewController.h"
#import "TalentShowModel.h"
@interface MJYShareCommentTableViewCell()

@property (nonatomic)MJYUserModel *model;

@end

@implementation MJYShareCommentTableViewCell


- (void)updateWith:(MJYUserModel *)model {
    self.model = model;

    [self.HaedImageView sd_setImageWithURL:[NSURL URLWithString:model.user_image] placeholderImage:[UIImage imageNamed:@"icn_11"]];
    self.HaedImageView.layer.cornerRadius = 15;
    self.HaedImageView.layer.masksToBounds = YES;
    [self createTapGesture];
    self.commentLabel.text = [NSString stringWithFormat:@"%@:%@",model.user_name,model.msg];
    self.timeLabel.text = model.create_time;
    
    [self setNeedsLayout];
}
- (void)createTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HeadImageViewClick)];
    [self.HaedImageView addGestureRecognizer:tap];
    
}
- (void)HeadImageViewClick {
    
    if (self.delegater != nil) {
        [self.delegater pushUpView:self.model];
    }

}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    //self.backgroundColor = [UIColor blackColor];
    self.HaedImageView.frame = CGRectMake(20, 20, 30, 30);
   
    self.commentLabel.frame = CGRectMake(self.HaedImageView.frame.size.width +self.HaedImageView.frame.origin.x + 5, self.HaedImageView.frame.origin.y, LCKScreenWidth - self.commentLabel.frame.origin.x-70, [MJYShareCommentTableViewCell commentLabelHeight:self.model.msg]);
    self.answerButton.frame = CGRectMake(self.commentLabel.frame.size.width + self.commentLabel.frame.origin.x + 5, self.commentLabel.frame.origin.y +10, 30, 20);
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x, self.commentLabel.frame.size.height + 20 , 200, 20);
    
}
+ (CGFloat)heightOfCellWithModel:(MJYUserModel*)model {
    return 20 + [MJYShareCommentTableViewCell commentLabelHeight:model.msg] + 40;
}
+ (CGFloat)commentLabelHeight:(NSString *)msg {
    if (msg.length == 0) {
        return 0.0;
    }
    CGRect rect = [msg boundingRectWithSize:CGSizeMake(LCKScreenWidth - 135, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    return rect.size.height;
    
}


- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
