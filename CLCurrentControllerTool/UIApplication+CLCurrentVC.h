//
//  UIApplication+CLCurrentVC.h
//  CLCurrentControllerTool
//
//  Created by chen liang on 2018/4/11.
//  Copyright © 2018年 chen liang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIApplication (CLCurrentVC)
@property (nonatomic, strong) UIViewController *currentVC;

@end
