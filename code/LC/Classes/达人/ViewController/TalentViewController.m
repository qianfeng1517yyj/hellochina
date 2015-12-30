//
//  TalentViewController.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "TalentViewController.h"
#import "HeadCollectionReusableView.h"
#import "MJYShareCollectionViewCell.h"
#import "TalentDetailModel.h"
#import "TalentShowCollectionViewCell.h"
#import "ShareDetailViewController.h"
@interface TalentViewController ()
@property(nonatomic)NSMutableArray *detailArray;
@property(nonatomic)TalentDetailModel*myModel;
@property(nonatomic,copy)NSString*url;

@property (nonatomic)NSArray *dataMJYArr;
@property (nonatomic)NSArray *dataTArr;
@property (nonatomic)BOOL isMJY;

@property (nonatomic)TalentShowModel *showModel;
@property (nonatomic)BOOL    isRefreshing;
@property (nonatomic)BOOL    isLoadingMore;


@end

@implementation TalentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailArray =[NSMutableArray array];
    [self fetchReferData];

    self.isMJY = YES;
    self.title = self.model.user_name;

    [self customNavidationBar];

    [self createHeadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *view = [self.tabBarController.view viewWithTag:10000];
    view.hidden = YES;
}
- (void)customNavidationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:nil target:self action:@selector(back)];
    self.title = self.model.user_name;
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark - 数据刷新


#pragma mark- 
#pragma mark - 数据解析
- (NSString*)composeUrl {
    return [NSString stringWithFormat:LCTalentShowRefer_url,self.model.user_id];
}
- (NSString*)composeLikeUrl {
    return [NSString stringWithFormat:LCTalentLike_Url,self.model.user_id];
   
}
- (NSString*)composeFocusUrl {

    return [NSString stringWithFormat:LCTalentShowFocus_Url,self.model.user_id];
}
- (NSString*)composeFansUrl {
    return [NSString stringWithFormat:LCTalentFans_Url,self.model.user_id];

}
- (void)fetchReferData {
    self.url =[self composeUrl];
   [[NetDataEngine sharedInstance]requsetTalentShowFrom:self.url success:^(id responsData) {
       self.myModel = [PaseData paseTalentHeardData:responsData];
       self.detailArray =[PaseData paseTalentDetailData:responsData];
       [self.collectionView reloadData];
       
   } failed:^(NSError *error) {
       
   }];
}
- (void)fetchFocusData {
   [[NetDataEngine sharedInstance]requsetTalentShowFrom:self.url success:^(id responsData) {
       
       self.detailArray =[PaseData paseTalentFocusData:responsData];
       [self.collectionView reloadData];
       
   } failed:^(NSError *error) {
       
   }];

}
- (void)fetchLikeData {
  [[NetDataEngine sharedInstance]requsetTalentShowFrom:self.url success:^(id responsData) {
      
      self.detailArray =[PaseData paseTalentDetailData:responsData];
      [self.collectionView reloadData];
      
  } failed:^(NSError *error) {
      
  }];

}
- (void)fetchFanData {
   [[NetDataEngine sharedInstance]requsetTalentShowFrom:self.url success:^(id responsData) {
       
       self.detailArray =[PaseData paseTalentFocusData:responsData];
       [self.collectionView reloadData];
       
   } failed:^(NSError *error) {
       
   }];

}
#pragma mark -
#pragma mark -创建视图
- (void)createHeadView {
    UINib *cellNib =[UINib nibWithNibName:@"MJYShareCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cellId"];
    
    UINib *nib =[UINib nibWithNibName:@"HeadCollectionReusableView" bundle:nil];
    
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadViewId"];
    self.layout.itemSize = CGSizeMake((LCKScreenWidth-60)/2, (LCKScreenWidth-30)/2);
    self.layout.headerReferenceSize = CGSizeMake(100, 150);
}

#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.detailArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if([self.url isEqualToString:[self composeUrl]]||[self.url isEqualToString:[self composeLikeUrl]]){
        MJYShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        MJYShareModel *model = [self.detailArray objectAtIndex:indexPath.item];
    
        [cell updateWith:model];
        
        return cell;
    }
      if([self.url isEqualToString:[self composeFocusUrl]]||[self.url isEqualToString:[self composeFansUrl]]){
        TalentShowCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"myCellId"forIndexPath:indexPath];
        TalentShowModel *model = [self.detailArray objectAtIndex:indexPath.item];
          _showModel = model;
        [cell updateDataWithModel:_showModel];
        return cell;
    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind  atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        HeadCollectionReusableView *headView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadViewId" forIndexPath:indexPath];
        headView.tagBlock = ^(NSInteger tag){
            [self pushNextVCWithTag:tag];
        };
        
        [headView updateDataHeightWithModel:self.myModel];
        
        return headView;
    }
    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (self.isMJY) {
        ShareDetailViewController *vc =[[ShareDetailViewController alloc]init];
        MJYShareModel *shareModel = self.detailArray[indexPath.row];
        vc.good_id = shareModel.goods_id;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        
        TalentViewController *talentVC = [[TalentViewController alloc]init];
        TalentShowModel *model =[self.detailArray objectAtIndex:indexPath.item];
        talentVC.model = model;
        [self.navigationController pushViewController:talentVC animated:YES];
    }

}
- (void)pushNextVCWithTag:(NSInteger)tag {
    
    switch (tag) {
        case 10:
            
        { self.url =[self composeLikeUrl];
            self.isMJY = YES;
            [self.detailArray removeAllObjects];
            [self fetchLikeData];
            [self createHeadView];
            
            
        }
            break;
            
        case 11:
        {
           self.isMJY = YES;
            self.url =[self composeUrl];
            [self.detailArray removeAllObjects];
            [self fetchReferData];
            [self createHeadView];
            
            
        }
            break;
        case 12:
        {
            self.isMJY = NO;
            self.url =[self composeFocusUrl];
            [self.detailArray removeAllObjects];
            [self createCollectionView];
            [self fetchFocusData];
            
            
        }
            break;
            
        case 13:
        {
            self.isMJY = NO;
            self.url =[self composeFansUrl];
            [self.detailArray removeAllObjects];
            [self createCollectionView];
            [self fetchFanData];
            
        }
            break;
        default:
            break;
    }
}
- (void)createCollectionView {
    self.layout =[[UICollectionViewFlowLayout alloc]init];
    self.layout.itemSize = CGSizeMake((LCKScreenWidth-80)/3,150);
    self.layout.sectionInset = UIEdgeInsetsMake(10, 20, 20, 20);
    
    self.layout.minimumInteritemSpacing = 10;
    self.layout.minimumLineSpacing      = 5;
    self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight) collectionViewLayout:self.layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    
    UINib *nib =[UINib nibWithNibName:@"TalentShowCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"myCellId"];
    UINib *nib1 =[UINib nibWithNibName:@"HeadCollectionReusableView" bundle:nil];
    [self.collectionView registerNib:nib1 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadViewId"];
    self.layout.headerReferenceSize = CGSizeMake(100, 150);
    [self.view addSubview:self.collectionView];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.5 animations:^{
        UIView *view = [self.tabBarController.view viewWithTag:10000];
        view.alpha = 0.01;
    }];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.5 animations:^{
        UIView *view = [self.tabBarController.view viewWithTag:10000];
        view.alpha = 1.0;
    }];
    
}

@end
