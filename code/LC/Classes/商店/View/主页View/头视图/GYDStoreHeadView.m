//
//  GYDStoreHeadView.m
//  LC
//
//  Created by qianfeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDStoreHeadView.h"
#import "StoreHeadModel.h"

@interface GYDStoreHeadView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThird;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFour;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFive;

@property (nonatomic, strong) NSArray *arr;

@end

@implementation GYDStoreHeadView

- (instancetype)init {
    if (self = [super init]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"GYDStoreHeadView" owner:nil options:nil] lastObject];
        [self addTagusture];
    }
    return self;
}
- (void)addTagusture {
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [self.imageViewOne addGestureRecognizer:gesture1];
    UITapGestureRecognizer *gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [self.imageViewTwo addGestureRecognizer:gesture2];
    UITapGestureRecognizer *gesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [self.imageViewThird addGestureRecognizer:gesture3];
    UITapGestureRecognizer *gesture4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [self.imageViewFive addGestureRecognizer:gesture4];
    UITapGestureRecognizer *gesture5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    [self.imageViewFour addGestureRecognizer:gesture5];
}
- (void)imageViewClick:(UITapGestureRecognizer *)recognizer {
    NSInteger tag = recognizer.view.tag;
    if (self.delegate!=nil) {
        [self.delegate headViewDidSelected:self.arr[tag - 500] tag:tag];
    }
}

- (void)updateWithArray:(NSArray *)arr {
    self.arr = arr;
    StoreHeadModel *model1 = arr[0];
    [self.imageViewOne sd_setImageWithURL:[NSURL URLWithString:model1.coverImg] placeholderImage:[UIImage imageNamed:@"storePlace"]];
    StoreHeadModel *model2 = arr[1];
    [self.imageViewTwo sd_setImageWithURL:[NSURL URLWithString:model2.coverImg] placeholderImage:[UIImage imageNamed:@"storePlace"]];
    StoreHeadModel *model3 = arr[2];
    [self.imageViewThird sd_setImageWithURL:[NSURL URLWithString:model3.coverImg] placeholderImage:[UIImage imageNamed:@"storePlace"]];
    StoreHeadModel *model4 = arr[3];
    [self.imageViewFour sd_setImageWithURL:[NSURL URLWithString:model4.coverImg] placeholderImage:[UIImage imageNamed:@"storePlace"]];
    StoreHeadModel *model5 = arr[4];
    [self.imageViewFive sd_setImageWithURL:[NSURL URLWithString:model5.coverImg] placeholderImage:[UIImage imageNamed:@"storePlace"]];
}




@end
