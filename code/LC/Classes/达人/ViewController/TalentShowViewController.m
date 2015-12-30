//
//  TalentShowViewController.m
//  LC
//
//  Created by QianFeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "TalentShowViewController.h"
#import "NetDataEngine.h"
#import "TalentShowModel.h"
#import "PaseData.h"
#import "TalentShowCollectionViewCell.h"
#import "TalentViewController.h"
#import "GYDSearchViewController.h"
#import "JHRefresh.h"

static NSString *collectionCellId =@"myCellId";

@interface TalentShowViewController ()

@property(nonatomic)NSMutableArray  *dataSource;
@property(nonatomic,assign)int      page;


@property (nonatomic)NSArray        *classArray;

@property (nonatomic) BOOL          isPath;;
@property (nonatomic,copy)NSString  *type;

@property (nonatomic)NSArray *yArr;

@property (nonatomic)BOOL    isRefreshing;
@property (nonatomic)BOOL    isLoadingMore;
@end

@implementation TalentShowViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIView *view = [self.tabBarController.view viewWithTag:10000];
    view.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNagivetionBar];
    [self initData];
    self.page = 1;
    [self createCollectionView];
    [self fetchTalentShowData];
    [self creatButtons];
    [self createRefreshHeadView];
    [self createRefreshFootView];

}
- (void)initData {
     _yArr = @[@"0",@"44",@"88",@"132",@"176",@"220"];
    self.classArray =@[@"搜索良品",@"默认推荐",@"最多推荐",@"最受欢迎",@"最新推荐",@"最新加入"];
   self.dataSource =[NSMutableArray array];
}
#pragma mark -
#pragma mark - 数据刷新
- (void)createRefreshHeadView
{
    __weak typeof(self)weakSelf = self;
    [self.collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.page = 1;
        weakSelf.isRefreshing = YES;
        [weakSelf fetchTalentShowData];
    }];
}

- (void)createRefreshFootView
{
    __weak typeof(self)weakSelf = self;
    [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.page++;
        weakSelf.isLoadingMore = YES;
        [weakSelf fetchTalentShowData];
    }];
}

- (void)endRefreshing
{
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    if (self.isLoadingMore) {
        self.isLoadingMore = NO;
        [self.collectionView footerEndRefreshing];
    }
}



#pragma mark -
#pragma mark - 数据解析
- (NSString*)composeTalentUrl {
    return [NSString stringWithFormat:LCTalentShow,self.page];

}
- (NSString*)composeUrl {
  
    return [NSString stringWithFormat:kCatagory_Url,self.type];
}
- (void)fetchTalentShowData {
    
    NSString *url =[self composeTalentUrl];
   [[NetDataEngine sharedInstance]requsetTalentShowFrom:url success:^(id responsData) {
       if (self.page == 1) {
           [self.dataSource removeAllObjects];
       }
       
       [self.dataSource addObjectsFromArray:[PaseData paseTalentData:responsData]];
    
       [self.collectionView reloadData];
       [self endRefreshing];
   } failed:^(NSError *error) {
       [self endRefreshing];
   }];
}

- (void)fetchTypeData {
  [[NetDataEngine sharedInstance]requsetTalentShowFrom:[self composeUrl] success:^(id responsData) {
      self.dataSource =[PaseData paseTalentData:responsData];
      [self.collectionView reloadData];
      [self endRefreshing];
  } failed:^(NSError *error) {
     [self endRefreshing];
  }];

}
- (void)createCollectionView {
    self.layout =[[UICollectionViewFlowLayout alloc]init];
    self.layout.itemSize = CGSizeMake((LCKScreenWidth-80)/3,150);
    self.layout.sectionInset = UIEdgeInsetsMake(10, 20, 20, 20);
    
    self.layout.minimumInteritemSpacing = 10;
    self.layout.minimumLineSpacing      = 5;
    _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight-64) collectionViewLayout:self.layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate   = self;
    
    UINib *nib =[UINib nibWithNibName:@"TalentShowCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:collectionCellId];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark -
#pragma mark - 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return  self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TalentShowCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    TalentShowModel *model =[self.dataSource objectAtIndex:indexPath.row];
    [cell updateDataWithModel:model];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
       TalentViewController *vc =[[TalentViewController alloc]init];
    
     TalentShowModel *model =[self.dataSource objectAtIndex:indexPath.item];
     vc.model = model;
     [self.navigationController pushViewController:vc animated:YES];

}

//----------------------导航栏样式定制----------------------


- (void)createNagivetionBar {
    UIImage *image = [UIImage imageNamed:@"btn_nav_option@2x"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(pathDown)];
    self.title = @"达人";
   self.navigationItem.leftBarButtonItem = item;
}

- (void)creatButtons {
    for(int i = 0;i <6;i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0,-100, 80,40);
        
        [btn setTitle:self.classArray[i]forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor =[UIColor blackColor];
        [btn addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 101+i;
        [self.view addSubview:btn];
    }
    _isPath = NO;
}
-(void)pathDown {
       if(_isPath == NO){
        for(int i = 0;i<6;i++){
            UIButton *btn = (UIButton*)[self.view viewWithTag:101+i];
            btn.transform = CGAffineTransformMakeRotation(M_PI);
            [UIView animateWithDuration:1 animations:^{
                btn.frame = CGRectMake(0, [_yArr[i] intValue],80,40);
                btn.alpha = 0.65;
                btn.transform = CGAffineTransformMakeRotation(2*M_PI);
            } completion:nil];
        }
        _isPath = YES;
    }else{
        for(int i = 0;i<6;i++){
            UIButton *btn = (UIButton*)[self.view viewWithTag:101+i];
            [UIView animateWithDuration:1 animations:^{
                btn.frame = CGRectMake(0,0,80, 40);
                btn.alpha = 0.f;
                btn.transform = CGAffineTransformMakeRotation(M_PI);} completion:nil];
        }
        _isPath = NO;
    }
}
- (void)updateData {
    [self composeUrl];
    [self.dataSource removeAllObjects];
    [self fetchTypeData];
}
- (void)btnDown:(UIButton*)btn{
    
    //收回去
    if (_isPath) {
        for(int i = 0;i<6;i++){
            UIButton *btn = (UIButton*)[self.view viewWithTag:101+i];
            [UIView animateWithDuration:1 animations:^{
                btn.frame = CGRectMake(-80,0,80,40);
                
                btn.transform = CGAffineTransformMakeRotation(M_PI);
            } completion:nil];
        }
        _isPath = NO;
    }

    switch (btn.tag) {
        case 101:{
            GYDSearchViewController *vc =[[GYDSearchViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 102:{
            self.isPath = YES;
            [self.dataSource removeAllObjects];
            [self fetchTalentShowData];
            
        }
            break;
        case 103:{
            
            self.type = kReferType;
            [self updateData];
            
        }
            break;
        case 104:{
            self.type = kPopularType;
            [self updateData];

        }
            break;
        case 105:{
            
            self.type = kNewReferType;
            [self updateData];
        }
        case 106:{
            
            self.type = kNewJoinType;
            [self updateData];
        }

            break;
        default:
            break;
    }
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
