//
//  MJYShareCollectionViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "MJYShareCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MJYShareCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)updateWith:(MJYShareModel *)model {
    
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image] placeholderImage:[UIImage imageNamed:@"placehold.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        float imageH = image.size.height;
        float imageW = image.size.width;
        if (imageH >= imageW) {
            float scaleY = self.size.height /imageH;
            float imageNewW = imageW * scaleY;
            self.imageView.frame = CGRectMake((self.size.width - imageNewW)/2, 0, imageNewW, self.size.height);
            
        }
        if (imageH < imageW) {
            float scaleX = self.size.width / imageW;
            float imageNewH = imageH * scaleX;
            self.imageView.frame = CGRectMake(0, (self.size.height - imageNewH)/2, self.size.width, imageNewH);
        }
    }];
}


@end
