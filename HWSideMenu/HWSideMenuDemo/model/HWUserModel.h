//
//  HWUserModel.h
//  HWSideMenu
//
//  Created by 黄文海 on 2018/1/20.
//  Copyright © 2018年 huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWSelectModel : NSObject
@property(nonatomic, copy)NSString* imageurl;
@property(nonatomic, copy)NSString* selectName;
@end


@interface HWUserModel : NSObject
@property(nonatomic, copy)NSString* headUrl;
@property(nonatomic, copy)NSString* backgroundImageUrl;
@property(nonatomic, copy)NSString* name;
@property(nonatomic, copy)NSString* grade;
@property(nonatomic, copy)NSString* personalWord;
@property(nonatomic, copy)NSArray<HWSelectModel*>* optionArray;

+ (instancetype)sharedInstance;
@end
