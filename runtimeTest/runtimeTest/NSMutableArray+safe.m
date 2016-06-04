//
//  NSMutableArray+safe.m
//  runtimeTest
//
//  Created by zzw on 16/6/3.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "NSMutableArray+safe.h"

@implementation NSMutableArray (safe)
+(void)load{
    
    
    id obj = [[self alloc] init];
    [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(my_objectAtIndex:)];
    
}

- (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector{
    
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

- (id)my_objectAtIndex:(NSInteger)index{

    if (self.count > index) {
      
        return  [self my_objectAtIndex:index];
        
    }else{
        
        return @"越界了";
    }
    

}
@end
