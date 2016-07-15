//
//  UIViewController+swzzing.m
//  runtimeTest
//
//  Created by zzw on 16/7/15.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "UIViewController+swzzing.h"

@implementation UIViewController (swzzing)
+(void)load{
    
    [self swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(my_viewWillAppear:)];
    
}

+ (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            
            method_exchangeImplementations(originalMethod , swizzledMethod);
            
        }
    });
    
}

- (void)my_viewWillAppear:(BOOL)animated{
    
    NSLog(@"已经交换了");
}
@end
