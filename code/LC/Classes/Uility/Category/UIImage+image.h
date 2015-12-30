//
//  UIImage+image.h
//  堆糖
//
//  Created by qianfeng on 15/9/21.
//  Copyright (c) 2015年 贵永冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

+ (UIImage *)imageWithOriginal:(NSString *)imageName;

+ (UIImage *)resizedImage:(NSString *)name;


@end
