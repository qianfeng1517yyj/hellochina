//
//  WQQCollectionTableViewCell.h
//  LC
//
//  Created by QianFeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WQQMagazineModel.h"

@interface WQQCollectionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *topic_name;

@property (weak, nonatomic) IBOutlet UILabel *cat_name;

- (void)updateWithModel:(WQQMagazineModel *)model;

@end
