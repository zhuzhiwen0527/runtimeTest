//
//  testViewController.m
//  runtimeTest
//
//  Created by zzw on 16/5/24.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "testViewController.h"
@interface testViewController(){
    NSInteger instance1;
    NSString * instance2;

}
@property (nonatomic,assign)NSInteger integer;

- (void)method2WithArg:(NSInteger)arg1 arg2:(NSString *)arg2;
@end
@implementation testViewController

- (void)method1{
    NSLog(@"This is method1");
}
- (void)method2{
}
+ (void)classMethod1{
}

- (void)method2WithArg:(NSInteger)arg1 arg2:(NSString *)arg2{

    NSLog(@"arg1: %ld,arg2: %@",arg1,arg2);

}
@end
