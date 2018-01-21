//
//  HWLeftViewController.m
//  HWSideMenu
//
//  Created by 黄文海 on 2018/1/20.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWLeftViewController.h"
#import "HWUserView.h"
#import "HWUserModel.h"

@interface HWLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView* tableView;
@property(nonatomic, copy)NSArray* selectOptionArray;
@end

@implementation HWLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width/6*5, height) style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    HWUserView* userView = [[HWUserView alloc] initWithFrame:CGRectMake(0, 0, width/6*5, height/3)];
    self.tableView.tableHeaderView = userView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.selectOptionArray = [HWUserModel sharedInstance].optionArray;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    HWSelectModel* model = self.selectOptionArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:model.imageurl];
    cell.textLabel.text = model.selectName;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectOptionArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
