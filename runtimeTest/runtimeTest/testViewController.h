//
//  testViewController.h
//  runtimeTest
//
//  Created by zzw on 16/5/24.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "testSuperViewController.h"
@interface testViewController : testSuperViewController
@property (nonatomic,copy)NSArray * arr;
@property (nonatomic,copy)NSString * str;

- (void)method1;
- (void)method2;
+ (void)classMethod1;
@end
