//
//  HWMessageModel.h
//  HWSideMenu
//
//  Created by 黄文海 on 2018/1/21.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HWMessageType)
{
    groupAssistant,
    qqWatch,
    groupChat,
    qqNews
};

@interface HWMessageModel : NSObject
@property(nonatomic, assign)HWMessageType type;
@property(nonatomic, copy)NSString* headImageUrl;
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* message;
@property(nonatomic, copy)NSString* time;
@end
