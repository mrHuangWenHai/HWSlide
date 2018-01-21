//
//  UIView+Frame.m
//  HWPageingViewExample
//
//  Created by 黄文海 on 2018/1/13.
//  Copyright © 2018年 huang. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)dtWidth {
    return self.frame.origin.x + CGRectGetWidth(self.frame);
}

- (CGFloat)dtHeight {
    return self.frame.origin.y + CGRectGetHeight(self.frame);
}

@end
