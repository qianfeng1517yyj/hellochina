//
//  TalentShowViewController.h
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalentShowViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic)UICollectionView          *collectionView;
@property(nonatomic)UICollectionViewFlowLayout*layout;

@end
