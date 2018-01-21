//
//  HWUserView.h
//  HWSideMenu
//
//  Created by 黄文海 on 2018/1/20.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "HWUserView.h"
#import "HWUserModel.h"
#import "UIView+Frame.h"

@interface HWUserView()
@property(nonatomic, strong)UIImageView* headImageView;
@property(nonatomic, strong)UIImageView* backgroundImageView;
@property(nonatomic, strong)UILabel* nameLabel;
@property(nonatomic, strong)UILabel* gradeLabel;
@property(nonatomic, strong)UILabel* personWordLabel;
@end

@implementation HWUserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews
{
    HWUserModel* model = [HWUserModel sharedInstance];
    _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.headUrl]];
    _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:model.backgroundImageUrl]];
    _backgroundImageView.frame = self.bounds;
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.text = model.name;
    _nameLabel.textColor = [UIColor whiteColor];
    _gradeLabel = [[UILabel alloc] init];
    _gradeLabel.text = model.grade;
    _personWordLabel = [[UILabel alloc] init];
    _personWordLabel.text = model.personalWord;
    _personWordLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_backgroundImageView];
    [self addSubview:_headImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_gradeLabel];
    [self addSubview:_personWordLabel];
}

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat headImageHead = (height/2+20)/3.5;
    CGFloat headImageY = height/2 - 20;
    CGFloat labelHeight = 30;
    
    self.headImageView.frame = CGRectMake(10,headImageY , headImageHead, headImageHead);
    self.nameLabel.frame = CGRectMake(self.headImageView.dtWidth + 5 ,headImageY , width - self.headImageView.dtWidth - 5, headImageHead);
    self.gradeLabel.frame = CGRectMake(10, self.headImageView.dtHeight + 5, width - 10, labelHeight);
    self.personWordLabel.frame = CGRectMake(10, self.gradeLabel.dtHeight + 5, width - 10, labelHeight);
}


@end
