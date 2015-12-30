//
//  WQQCollectionTableViewCell.m
//  LC
//
//  Created by QianFeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//
#import "NSDate+Extension.h"
#import "WQQCollectionTableViewCell.h"

@interface WQQCollectionTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *collectTIme;

@end

@implementation WQQCollectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateWithModel:(WQQMagazineModel *)model {
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_img_new] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.topic_name.text = model.topic_name;
   
    
    self.collectTIme.text = [NSString stringWithFormat:@"收藏：%@",[self getCollentionTime:model.addtime]];
    
    if (model.author_name.length > 0) {
        self.cat_name.text = [NSString stringWithFormat:@"#%@·%@",model.cat_name,model.author_name];
    }else {
        self.cat_name.text = [NSString stringWithFormat:@"#%@",model.cat_name];
    }
}


/**
 *  重写create_time的get方法
 */
- (NSString *)getCollentionTime:(NSString *)time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 帖子创建时间
    NSDate *createDate = [fmt dateFromString:time];
    
    if (createDate.isThisYear) { // 今年
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFromDate:createDate];
            if (cmps.hour >= 1) { // 1个小时 > 时间差
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1个小时 > 时间差 > 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差
                return @"刚刚";
            }
        } else if (createDate.isYesterDay) {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:createDate];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        return time;
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
