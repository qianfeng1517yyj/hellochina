//
//  AuthorViewController.m
//  LC
//
//  Created by QianFeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "AuthorViewController.h"
#import "WQQAuthorModel.h"
#import "WQQAuthorTableViewCell.h"
@interface AuthorViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) UITableView *tableView;

//@property (nonatomic) NSArray *dataSource;

@end

@implementation AuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self fetchData];
}

#pragma mark -
#pragma mark 重写父类方法
- (void)createUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LCKScreenWidth, LCKScreenHeight-64-70)];
    self.tableView.backgroundColor = LCBaseMagazineColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"WQQAuthorTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"WQQAuthorTableViewCellId"];
    [self.view addSubview:self.tableView];
}

- (NSString *)composeRequsetUrl {
    return LCMagazineAuthorUrl;
}

- (void)parsingResponsData:(id)responsData {
    self.dataSource = (NSMutableArray *)[WQQAuthorModel parsingWithRespondData:responsData];
    [self.tableView reloadData];
}

#pragma mark - 
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WQQAuthorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WQQAuthorTableViewCellId" forIndexPath:indexPath];
    WQQAuthorModel *model = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateWithModel:model];
    cell.backgroundColor = LCBaseMagazineColor;
    return cell;
}

#pragma mark - 
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
    (NSIndexPath *)indexPath {
    WQQAuthorModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(goBack:title:)]) {
        [self.delegate goBack:[NSString stringWithFormat:LCMagazineAuthorGoBackUrl,model.author_id] title:model.author_name ];
    }

}



@end
