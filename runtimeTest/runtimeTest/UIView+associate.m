//
//  UIView+associate.m
//  runtimeTest
//
//  Created by zzw on 16/6/3.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "UIView+associate.h"

static char  kDTActionHandlerTapGestureKey ;
static char  kDTActionHandlerTapBlockKey ;
@implementation UIView (associate)


- (void)setTapActionWithBlock:(void(^)())block{
  
    UITapGestureRecognizer * gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    if (!gesture) {
     
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
        
    }
    
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);

}

- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture{

    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action)
        {
            action();
        }
    }


}
@end
