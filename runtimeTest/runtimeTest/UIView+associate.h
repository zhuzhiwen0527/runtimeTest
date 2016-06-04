//
//  UIView+associate.h
//  runtimeTest
//
//  Created by zzw on 16/6/3.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (associate)
- (void)setTapActionWithBlock:(void(^)())block;
@end
