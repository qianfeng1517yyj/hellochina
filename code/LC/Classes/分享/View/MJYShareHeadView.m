//
//  MJYShareHeadView.m
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "MJYShareHeadView.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
@implementation MJYShareHeadView

- (void)layoutSubviews {
    [super layoutSubviews];

    [self createScrollView];
    [self createLabelView];
    [self createPageController];
    

}
- (void)createScrollView {
    NSArray *imageNameArr = self.model.images_item;
    self.scrollerView.frame = CGRectMake(0,0, LCKScreenWidth, LCKScreenWidth);
    for (int i = 0; i < imageNameArr.count; i++) {

        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.center = self.scrollerView.center;
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageNameArr[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            float imageH = image.size.height;
            float imageW = image.size.width;
            if (imageH >= imageW) {
                float scaleY = self.scrollerView.height /imageH;
                float imageNewW = imageW * scaleY;
                imageView.frame = CGRectMake((self.scrollerView.width - imageNewW)/2 + self.scrollerView.width * i, 0, imageNewW, self.scrollerView.height);
                
            }
            if (imageH < imageW) {
                float scaleX = self.scrollerView.width / imageW;
                float imageNewH = imageH * scaleX;
                imageView.frame = CGRectMake( self.scrollerView.width * i,(self.scrollerView.height - imageNewH)/2, self.scrollerView.width, imageNewH);
            }

            [self.scrollerView addSubview:imageView];
        }];

    } 
    self.scrollerView.delegate = self;
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    self.scrollerView.showsVerticalScrollIndicator = NO;
    self.scrollerView.contentSize = CGSizeMake(imageNameArr.count * self.scrollerView.width, self.scrollerView.height);
}
- (void)createPageController {
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.pageControl.center = CGPointMake(self.scrollerView.center.x, self.scrollerView.center.y + LCKScreenWidth/2 - 20);
    self.pageControl.numberOfPages = self.model.images_item.count;
    self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:self.pageControl];
                                                    
}


+ (CGFloat)NameLabelheightWith:(NSString *)goodName {
    if (goodName.length == 0) {
        return 0.0;
 }
    CGRect rect = [goodName boundingRectWithSize:CGSizeMake(LCKScreenWidth-60, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    return rect.size.height;
}
- (void)createLabelView {
    
    self.nameLabel.text = self.model.goods_name;
    self.nameLabel.frame = CGRectMake(20, LCKScreenWidth + 10, LCKScreenWidth - 70, [MJYShareHeadView NameLabelheightWith:self.model.goods_name]);
    
    self.likeImageView.image = [UIImage imageNamed:@"btn_favorite@2x"];
    self.likeImageView.frame = CGRectMake(LCKScreenWidth - 50, self.nameLabel.frame.origin.y, 25, 25);
    self.likeLabel.text = self.model.like_count;
    self.likeLabel.frame = CGRectMake(self.likeImageView.frame.origin.x+5, self.likeImageView.frame.origin.y + self.likeImageView.frame.size.height + 2, 40, 20) ;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",self.model.price];
    self.priceLabel.frame = CGRectMake(20, self.nameLabel.frame.size.height + 2 + self.nameLabel.frame.origin.y, 100, 20);
    

    self.owerImageView.frame = CGRectMake(20, self.priceLabel.frame.size.height + self.priceLabel.frame.origin.y + 10, 30, 30);
    
    [self.owerImageView sd_setImageWithURL:[NSURL URLWithString:self.model.owner_image] placeholderImage:[UIImage imageNamed:@"icn_11"]];
    
    self.owerImageView.layer.cornerRadius = 15;
    self.owerImageView.layer.masksToBounds = YES;
    [self createTapGesture];
    self.owerNameLabel.text = [NSString stringWithFormat:@"%@ 推荐",self.model.owner_name];
    self.owerNameLabel.frame = CGRectMake(self.owerImageView.frame.origin.x + self.owerImageView.frame.size.width + 5, self.owerImageView.frame.origin.y, LCKScreenWidth - 20, 30);
 
}
- (void)createTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(owerImageViewClick)];
    [self.owerImageView addGestureRecognizer:tap];
    
}
- (void)owerImageViewClick {
    if (self.delegater) {
        [self.delegater pushViewWithUser:self.model];
    }
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MJYShareHeadView" owner:nil options:nil]lastObject];
    }
    return self;
}
+ (CGFloat)heightForHeadViewWith:(MJYShareModel *)model {
    return [MJYShareHeadView NameLabelheightWith:model.goods_name] + LCKScreenWidth + 10 + 20 + 60;
}
#pragma mark - scrollDelegate 

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = self.scrollerView.contentOffset;
    NSInteger pageNumber = offset.x/self.scrollerView.bounds.size.width;
    self.pageControl.currentPage = pageNumber;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
