//
//  ViewController.m
//  runtimeTest
//
//  Created by zzw on 16/5/24.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = 2;
    [self ex_registerClassPair];
    
//    NSLog(@"%s",class_getName([self class]));
//    NSLog(@"%@",class_getSuperclass([self class]));
//    NSLog(@"%d",class_isMetaClass([self class]));
//    NSLog(@"%zu",class_getInstanceSize([self class]));
//    
//    
//    //获取属性名以及值
//    unsigned  int count;
//    objc_property_t * property = class_copyPropertyList([self class], &count);
//    objc_property_t pro = property[0];
//    const char * name = property_getName(pro);
//    NSLog(@"%s",name);
//    NSLog(@"%@",[self valueForKey:[NSString stringWithUTF8String:name]]);
    
    testViewController * test = [[testViewController alloc] init];
    
    unsigned int outCount = 0;
    Class cls = test.class;
    NSLog(@"==================================");

    //类名
    NSLog(@"class name:%s",class_getName(cls));
    NSLog(@"==================================");
    
    //父类
    NSLog(@"super class name:%s",class_getName(class_getSuperclass(cls)));
    
    NSLog(@"==================================");
    
    //是否是元类
    NSLog(@"testViewController is %s a meta-class",(class_isMetaClass(cls) ? "":"not"));
    NSLog(@"==================================");
    
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s ",class_getName(cls),class_getName(meta_class));
    NSLog(@"==================================");
    //实例变量大小
    NSLog(@"instance size :%zu",class_getInstanceSize(cls));
    NSLog(@"==================================");
    //成员变量
    Ivar * ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        
        NSLog(@"instance variable's name:%s at index :%d",ivar_getName(ivar),i);
        
    }
    free(ivars);
    Ivar string = class_getInstanceVariable(cls, "_str");
    
    if (string) {
        NSLog(@"instance variable %s",ivar_getName(string));
    }
    NSLog(@"==================================");
    //属性操作
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name;%s",property_getName(property));
    }
    free(properties);
    objc_property_t array = class_getProperty(cls, "arr");
    if (array) {
        NSLog(@"property %s",property_getName(array));
        
    }
    NSLog(@"==================================");
    //方法操作
    Method * methods = class_copyMethodList(cls, &outCount);
    
    for (int i = 0 ; i < outCount ; i++) {
        Method method = methods[i];
        
    }
}



//c方法
void testMetaClass(id self,SEL _cmd){
    NSLog(@"This object  is %p",self);
    NSLog(@"Class id %@,super class is %@",[self class],[self superclass]);
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following thr isa pointer %d times gives %p",i,currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }

    NSLog(@"NSObject's class is %p",[NSObject class]);
    NSLog(@"NSObjects meta class is %p",objc_getClass((__bridge void*)[NSObject class]));
    
}

//动态添加类  及方法
- (void)ex_registerClassPair{
    
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0) ;
   BOOL didAddMethod =  class_addMethod(newClass, @selector(testMetaClass), (IMP)testMetaClass, "v@:");
    //动态添加类
    objc_registerClassPair(newClass);
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    if (didAddMethod) {

          [instance performSelector:@selector(testMetaClass)];
    }
  

}
- (void)test{

    NSLog(@"喵喵");

}
@end
