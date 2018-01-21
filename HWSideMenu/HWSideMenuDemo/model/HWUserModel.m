//
//  HWUserModel.m
//  HWSideMenu
//
//  Created by 黄文海 on 2018/1/20.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWUserModel.h"

@implementation HWSelectModel

@end

@implementation HWUserModel

+ (instancetype)sharedInstance
{
    static HWUserModel* model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[HWUserModel alloc] init];
    });
    
    return model;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    self.headUrl = @"head";
    self.backgroundImageUrl = @"background";
    self.name = @"兰亭白菜";
    self.grade = @"🌞🌞🌛🌛✨";
    self.personalWord = @"编辑个性签名";
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    HWSelectModel* model1 = [[HWSelectModel alloc] init];
    model1.selectName = @"了解会员特权";
    model1.imageurl = @"supergust";
    [array addObject:model1];
    
    HWSelectModel* model2 = [[HWSelectModel alloc] init];
    model2.selectName = @"个性装扮";
    model2.imageurl = @"de";
    [array addObject:model2];
    
    HWSelectModel* model3 = [[HWSelectModel alloc] init];
    model3.selectName = @"我的文件";
    model3.imageurl = @"file";
    [array addObject:model3];
    
    HWSelectModel* model4 = [[HWSelectModel alloc] init];
    model4.selectName = @"我的收藏";
    model4.imageurl = @"like";
    [array addObject:model4];
    
    self.optionArray = [array copy];
}

@end
