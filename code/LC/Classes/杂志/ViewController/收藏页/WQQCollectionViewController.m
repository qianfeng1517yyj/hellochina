//
//  WQQCollectionViewController.m
//  LC
//
//  Created by QianFeng on 15/10/6.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "WQQCollectionViewController.h"
#import "WQQCollectionTableViewCell.h"
#import "WQQMagazineModel.h"
#import "WQQDetailViewController.h"

#define LCROWHEIGHT 210

@interface WQQCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * _dataArray;
    UIButton * _deleteButton;
    NSIndexPath * _editingIndexPath;
}
@property (nonatomic) UITableView *tableView;

@property (nonatomic)NSArray *dataSource;

@end

@implementation WQQCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigateionLeftItem];
//  [self createNavigateionRightItem];
    [self createUI];
//    self.title = @"我的收藏";
}

#pragma mark -
#pragma mark 设置NavigationItem
- (void)createNavigateionLeftItem {
    UIButton *button = [CustomViewFactory createButton:CGRectMake(0, 0, 40, 40) backgourdImage:[UIImage imageNamed:@"loginBack.png"]];
    button.tag = 17;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)createNavigateionRightItem {
    // 编辑
    UIButton *button = [CustomViewFactory createButton:CGRectMake(0, 0, 40, 40) backgourdImage:[UIImage imageNamed:@"btn_ware_forward@2x.png"]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.tag = 27;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)buttonClick:(UIButton *)button {
    // 返回
    if (button.tag == 17) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    // 编辑
    if (button.tag == 27) {
        
        
    }
}

#pragma mark -
#pragma mark 创建UI
- (void)createUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight-64)];
    self.tableView.backgroundColor = LCBaseColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"WQQCollectionTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma UITableViewDataSource 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[WQQDBManager sharedInstance] readManagerModelInfoList].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WQQCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    WQQMagazineModel *model = [[[WQQDBManager sharedInstance] readManagerModelInfoList] objectAtIndex:indexPath.row];
    [cell updateWithModel:model];
    [self tableViewCellOriginalLocation:cell];
    return cell;
}

#pragma mark - 
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LCROWHEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WQQMagazineModel *model = [[[WQQDBManager sharedInstance] readManagerModelInfoList] objectAtIndex:indexPath.row];
    WQQDetailViewController *detail = [[WQQDetailViewController alloc] init];
    detail.model = model;
    [self.navigationController  pushViewController:detail animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataArray removeObjectAtIndex:indexPath.row];
        WQQMagazineModel *model = [[[WQQDBManager sharedInstance] readManagerModelInfoList] objectAtIndex:indexPath.row];
        [[WQQDBManager sharedInstance] deleteManagerModelInfo:model];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
       
    }
}


#pragma mark -
#pragma mark UIScrollViewDelegate 代理方法 左上角的滚动显示
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self interfaceAnimation];
}
// 界面显示动画
- (void)interfaceAnimation {
    WQQCollectionTableViewCell *cell = [[self.tableView visibleCells] firstObject];
    
    if (self.tableView.contentOffset.y >= cell.topY) {
        
        CGFloat height = cell.bottom - self.tableView.contentOffset.y;
        CGFloat scale = 1 - (height / cell.height);
        cell.iconImageView.alpha = 1 - 0.5 *scale;
        cell.iconImageView.frame = CGRectMake(25*scale, LCROWHEIGHT - height, LCKScreenWidth - 50*scale, LCROWHEIGHT);
        cell.layer.masksToBounds = YES;
    }
    if (self.tableView.contentOffset.y >= cell.topY + 70  && self.tableView.contentOffset.y <= cell.bottom-65) {
        CGFloat height = self.tableView.contentOffset.y - cell.topY + 10;
        cell.topic_name.frame = CGRectMake(0, height, LCKScreenWidth, 25);
        cell.cat_name.frame = CGRectMake(0, height+30, LCKScreenWidth, 20);
    }
    if (self.tableView.contentOffset.y < cell.topY) {
        [self tableViewCellOriginalLocation:cell];
    }
    
    if ([self.tableView visibleCells].count >= 2) {
        WQQCollectionTableViewCell *cell1 = [[self.tableView visibleCells] objectAtIndex:1];
        if (self.tableView.contentOffset.y < cell1.topY) {
            [self tableViewCellOriginalLocation:cell1];
        }
    }
    
}

// 初始化cell的位置
- (void)tableViewCellOriginalLocation:(WQQCollectionTableViewCell *)cell {
    cell.iconImageView.frame = CGRectMake(0, 0, LCKScreenWidth, LCROWHEIGHT);
    cell.topic_name.frame = CGRectMake(0, 80, LCKScreenWidth, 25);
    cell.cat_name.frame = CGRectMake(0, 110, LCKScreenWidth, 20);
    cell.iconImageView.alpha = 1;
}




@end
