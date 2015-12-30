//
//  ShareDetailViewController.m
//  LC
//
//  Created by qianfeng on 15/10/4.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "ShareDetailViewController.h"
#import "MJYShareHeadView.h"
#import "MJYShareCommentTableViewCell.h"
#import "TalentViewController.h"
@interface ShareDetailViewController ()<UITableViewDataSource,UITableViewDelegate,MJYShareCommentTableViewCellDelegate,MJYShareHeadViewDelegate>


@property (nonatomic)NSMutableArray *commentArr;
@property (nonatomic)MJYShareModel *model;
@property (nonatomic)UITableView *tableView;
@end

@implementation ShareDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
   
    self.commentArr = [NSMutableArray array];
    [self customUpDataSource];
    [self customDownDataSource];
    [self customTableView];
    [self customNavidationBar];
     self.tableView.backgroundColor = [UIColor blackColor];

}
- (void)customNavidationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_back" highImageName:nil target:self action:@selector(back)];
    self.title = @"良品";
}
- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark - 请求数据
- (void)customUpDataSource {
    self.model = [[MJYShareModel alloc]init];
    NSString *url = [NSString stringWithFormat:LCShareUpDetailUrl,self.good_id];
   [[NetDataEngine sharedInstance]requsetShareFrom:url success:^(id responsData) {
       self.model = [PaseData paseShareUpDetailData:responsData];
       
       [self customUpUI];
   } failed:^(NSError *error) {

   }];
}
- (void)customDownDataSource {
    
    self.commentArr = [NSMutableArray array];
    NSString *url = [NSString stringWithFormat:LCShareDownDetailUrl,self.good_id];
    [[NetDataEngine sharedInstance]requsetShareFrom:url success:^(id responsData) {
        self.commentArr = [PaseData paseShareDownDetailData:responsData];
        
        [self.tableView reloadData];
       
    } failed:^(NSError *error) {
       
    }];
}
#pragma mark -
#pragma mark - 创建UI
- (void)customUpUI {
    MJYShareHeadView *headView = [[MJYShareHeadView alloc]init];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goBack:)];
    [headView.scrollerView addGestureRecognizer:tapGesture];
    headView.model = self.model;
    headView.frame =CGRectMake(0, 0, LCKScreenWidth, [MJYShareHeadView heightForHeadViewWith:self.model]);
    headView.delegater = self;
    self.tableView.tableHeaderView = headView;
    [self.tableView reloadData];

}

- (void)goBack:(UITapGestureRecognizer *)tap {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)customTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight-64)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"MJYShareCommentTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"commentCellId"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
#pragma mark -
#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJYShareCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCellId" forIndexPath:indexPath];
    cell.delegater = self;

    MJYUserModel *userModel = self.commentArr[indexPath.row];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateWith:userModel];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MJYUserModel *userModel = self.commentArr[indexPath.row];
   return [MJYShareCommentTableViewCell heightOfCellWithModel:userModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - MJYShareCommentTableViewCellDelegate

- (void)pushUpView:(MJYUserModel *)model {
    TalentViewController *vc =[[TalentViewController alloc]init];
    
    
    TalentShowModel *tModel = [[TalentShowModel alloc] init];
    tModel.user_id = [NSString stringWithFormat:@"%ld",model.user_id];
    tModel.user_name = model.user_name;
    tModel.is_daren = model.is_daren;
    tModel.user_image = model.user_image;
    tModel.user_desc = model.user_desc;
    vc.model = tModel;
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)pushViewWithUser:(MJYShareModel *)model {
    
    TalentViewController *vc =[[TalentViewController alloc]init];
    
    TalentShowModel *tModel = [[TalentShowModel alloc] init];
    tModel.user_id = model.owner_id;
    tModel.user_name = model.owner_name;
    tModel.user_image = model.owner_image;
    tModel.user_desc = model.owner_desc;
    vc.model = tModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
