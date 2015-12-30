//
//  GYDDetailHeadView.m
//  LC
//
//  Created by qianfeng on 15/10/5.
//  Copyright (c) 2015年 第一小组二分队. All rights reserved.
//

#import "GYDDetailHeadView.h"

@interface GYDDetailHeadView ()<UITableViewDataSource, UITableViewDelegate>
{
    BOOL isNameButtonClick;
}
@property (nonatomic) StoreItemModel *childrenModel;


@property (nonatomic) NSMutableArray *dataSoure;

@property (nonatomic) UITableView *tableView;


@end

@implementation GYDDetailHeadView

- (void)awakeFromNib {
    self.dataSoure = [NSMutableArray array];
}
- (void)udpateWithModel:(StoreItemModel *)model {
    self.childrenModel = model;
    [self.nameButton setTitle:model.name forState:UIControlStateNormal];
}
- (IBAction)nameButtonClick:(id)sender {
    [self.dataSoure removeAllObjects];
    isNameButtonClick = YES;
    [self.dataSoure addObject:self.superModel];
    [self.dataSoure addObjectsFromArray:self.superModel.children];
    CGFloat height = self.dataSoure.count * 44;
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, LCKScreenWidth, height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tag = 2000;
        [self.bgView addSubview:self.tableView];
        self.tableView.hidden = YES;
    }else {
        self.tableView.frame = CGRectMake(0, 40, LCKScreenWidth, height);
        [self.tableView reloadData];
    }
    if (isNameButtonClick) {
        self.tableView.hidden = !self.tableView.isHidden;
    }
}
- (IBAction)priceButtonClick:(id)sender {
    isNameButtonClick = NO;
    self.dataSoure = [NSMutableArray arrayWithArray:@[@"全部",@"0-200",@"201-500",@"501-1000",@"1001-3000",@"3000以上"]];
    CGFloat height = self.dataSoure.count * 44;
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, LCKScreenWidth, height) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tag = 2000;
        [self.bgView addSubview:self.tableView];
        self.tableView.hidden = YES;
    }else {
        self.tableView.frame = CGRectMake(0, 40, LCKScreenWidth, height);
        [self.tableView reloadData];
    }
    if (!isNameButtonClick) {
        self.tableView.hidden = !self.tableView.isHidden;
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.backgroundColor = [UIColor colorWithRed:193/225.0 green:205/225.0 blue:205/225.0 alpha:1.0];
    if (isNameButtonClick) {
        StoreItemModel *model = self.dataSoure[indexPath.row];
        if (indexPath.row == 0) {
            cell.textLabel.text = @"全部";
        }else {
            cell.textLabel.text = model.name;
        }
        
    }else {
        cell.textLabel.text = self.dataSoure[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isNameButtonClick) {
        StoreItemModel *model = self.dataSoure[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(detailHeadViewDidSelected:)]) {
            if (indexPath.row == 0) {
                [self.nameButton setTitle:@"全部" forState:UIControlStateNormal];
                model.name = @"全部";
            }else {
                [self.nameButton setTitle:model.name forState:UIControlStateNormal];
            }
            [self.delegate detailHeadViewDidSelected:model];
        }
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(detailHeadViewPriceSelected:)]) {
            [self.delegate detailHeadViewPriceSelected:self.dataSoure[indexPath.row]];
            NSString *price = self.dataSoure[indexPath.row];
            if ([price isEqualToString:@"全部"]) {
                [self.priceButton setTitle:@"价格筛选" forState:UIControlStateNormal];
            }else {
                [self.priceButton setTitle:price forState:UIControlStateNormal];
            }
        }
    }
    self.tableView.hidden = YES;
}



@end
