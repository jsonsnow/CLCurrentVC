//
//  UIApplication+CLCurrentVC.m
//  CLCurrentControllerTool
//
//  Created by chen liang on 2018/4/11.
//  Copyright © 2018年 chen liang. All rights reserved.
//

#import "UIApplication+CLCurrentVC.h"

static char *currentVCKey = "currentVCKey";
@implementation UIApplication (CLCurrentVC)

- (void)setCurrentVC:(UIViewController *)currentVC {
    objc_setAssociatedObject(self, currentVCKey, currentVC, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)currentVC {
    return objc_getAssociatedObject(self, currentVCKey);
}
@end
