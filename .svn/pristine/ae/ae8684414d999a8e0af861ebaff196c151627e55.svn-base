//
//  GYDFirstCollectionViewCell.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDFirstCollectionViewCell.h"

@interface GYDFirstCollectionViewCell ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@property (nonatomic) GYDItemoModel *model;

@end

@implementation GYDFirstCollectionViewCell

- (void)awakeFromNib {
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator  = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
}
- (void)updateWithModel:(GYDItemoModel *)model {
    self.model = model;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    self.likeLabel.text = model.like_count;
    [self setUpScrollView];
    [self setUpPageControl];
}
- (void)setUpScrollView {
    for (int index = 1; index <= self.model.images_item.count; index++) {
        NSString *imageName = self.model.images_item[index-1];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((index-1)*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
        [_scrollView addSubview:imageView];
    }
    //这里设置以下contentSize的大小，指定scrollView显示内容的区域大小
    _scrollView.contentSize = CGSizeMake(self.model.images_item.count*_scrollView.bounds.size.width, _scrollView.bounds.size.height);
}
- (void)setUpPageControl {
    self.pageControl.numberOfPages = self.model.images_item.count;
}

#pragma mark - UIScrollViewDelegate 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //得到当前的偏移
    CGPoint offset = scrollView.contentOffset;
    //使用偏移量计算页码
    NSInteger pageNumber = offset.x/scrollView.bounds.size.width;
    
    //设置pageController的当前页，对应的原点高亮显示
    self.pageControl.currentPage = pageNumber;
}




@end
