//
//  HWMessageViewController.m
//  HWSideMenu
//
//  Created by 黄文海 on 2018/1/20.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWMessageViewController.h"
#import "UIImage+Extension.h"
#import "HWSideMenuViewController.h"
#import "HWMessageCell.h"
#import "HWMessageModel.h"
#import "HWMessageCell.h"

@interface HWMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic, copy)NSArray* dataSource;
@property(nonatomic, strong)UITableView* tableView;
@end

@implementation HWMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"head"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(presentLeftMenuViewController)];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, height - 128)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 70, 0, 0)];
    [self.tableView registerNib:[UINib nibWithNibName:@"HWMessageCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWMessageCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    HWMessageModel* model = self.dataSource[indexPath.row];
    cell.headImageView.image = [UIImage imageNamed:model.headImageUrl];
    cell.messageLabel.text = model.message;
    cell.titleLabel.text = model.title;
    cell.timeLabel.text = model.time;
    return cell;
}

- (void)loadData
{
    HWMessageModel* model1 = [[HWMessageModel alloc] init];
    model1.type = groupAssistant;
    model1.headImageUrl = @"groupAssistant";
    model1.title = @"群助手";
    model1.message = @"[8个新消息]";
    model1.time = @"上午 12:07";
    
    HWMessageModel* model2 = [[HWMessageModel alloc] init];
    model2.type = qqWatch;
    model2.headImageUrl = @"qqWatch";
    model2.title = @"qq看点";
    model2.message = @"呆瓜不是瓜:黄毅清宣布退出";
    model2.time = @"上午 12:07";
    
    HWMessageModel* model3 = [[HWMessageModel alloc] init];
    model3.type = groupChat;
    model3.headImageUrl = @"groupChat";
    model3.title = @"计科1401黄文海";
    model3.message = @"哈哈";
    model3.time = @"上午 12:07";
    
    HWMessageModel* model4 = [[HWMessageModel alloc] init];
    model4.type = qqNews;
    model4.headImageUrl = @"groupNews";
    model4.title = @"腾讯新闻";
    model4.message = @"这个冬天最强的《演员》:周一围这一跪让全场飙泪";
    model4.time = @"上午 12:07";
    
    self.dataSource = @[model1,model2,model3,model4];
    
}

- (void)presentLeftMenuViewController
{
    HWSideMenuViewController* sideMenu = self.sideMenuViewController;
    if (sideMenu) {
        [sideMenu presentLeftMenuViewController];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (HWSideMenuViewController*)sideMenuViewController
{
    UIViewController* iter = self.parentViewController;
    while (iter) {
        if ([iter isKindOfClass:[HWSideMenuViewController class]]) {
            return (HWSideMenuViewController*)iter;
        } else if (iter.parentViewController) {
            iter = iter.parentViewController;
        } else {
            iter = nil;
        }
    }
    return nil;
}

@end
