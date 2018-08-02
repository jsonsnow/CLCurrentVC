//
//  UIViewController+VCCurrentVCCategory.m
//  VCFinances
//
//  Created by chen liang on 2018/4/10.
//  Copyright © 2018年 weiclicai. All rights reserved.
//

#import "UIViewController+VCCurrentVCCategory.h"
#import "UIApplication+CLCurrentVC.h"

@implementation NSObject (VCChange)

+ (void)exchangeInstanceMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getInstanceMethod(self, method1), class_getInstanceMethod(self, method2));
}

+ (void)exchangeClassMethod1:(SEL)method1 method2:(SEL)method2
{
    method_exchangeImplementations(class_getClassMethod(self, method1), class_getClassMethod(self, method2));
}

@end

@implementation UITabBarController (VCChangeMethod)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(setSelectedViewController:) method2:@selector(vc_setSelectedViewController:)];
}

- (void)vc_setSelectedViewController:(__kindof UIViewController *)selectedViewController {
    [UIApplication sharedApplication].currentVC = selectedViewController;
    if ([selectedViewController isKindOfClass:NSClassFromString(@"UINavigationController")]) {
        [UIApplication sharedApplication].currentVC = ((UINavigationController *)selectedViewController).topViewController;
    }
    [self vc_setSelectedViewController:selectedViewController];
}
@end

@implementation UIViewController (VCChangeMethod)

+ (void)load {
    [self exchangeInstanceMethod1:@selector(presentViewController:animated:completion:) method2:@selector(vc_presentViewController:animated:completion:)];
    [self exchangeInstanceMethod1:@selector(dismissViewControllerAnimated:completion:) method2:@selector(vc_dismissViewControllerAnimated:completion:)];
}

- (void)vc_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [UIApplication sharedApplication].currentVC = viewControllerToPresent;
    if ([viewControllerToPresent isKindOfClass:NSClassFromString(@"UINavigationController")]) {
        [UIApplication sharedApplication].currentVC = ((UINavigationController *)viewControllerToPresent).topViewController;
    }
    [self vc_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)vc_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    if (self.presentationController) {
        [UIApplication sharedApplication].currentVC = self.presentingViewController;
    }
    [self vc_dismissViewControllerAnimated:flag completion:completion];
}

@end

@implementation UINavigationController (VCChangeMethod)
+ (void)load {
    [self exchangeInstanceMethod1:@selector(pushViewController:animated:) method2:@selector(vc_pushViewController:animated:)];
    [self exchangeInstanceMethod1:@selector(popViewControllerAnimated:) method2:@selector(vc_popViewControllerAnimated:)];
    [self exchangeInstanceMethod1:@selector(popToRootViewControllerAnimated:) method2:@selector(vc_popToRootViewControllerAnimated:)];
    [self exchangeInstanceMethod1:@selector(popToViewController:animated:) method2:@selector(vc_popToViewController:animated:)];
    
}

- (void)vc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //改情况为创建navc初始rootCtr的时候
    [UIApplication sharedApplication].currentVC = viewController;
    [self vc_pushViewController:viewController animated:animated];
}

- (UIViewController *)vc_popViewControllerAnimated:(BOOL)animated {
    if (self.viewControllers.count >= 2) {
          [UIApplication sharedApplication].currentVC = self.viewControllers[self.viewControllers.count - 2];
    } else
        [UIApplication sharedApplication].currentVC = self.viewControllers[0];
    return [self vc_popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)vc_popToRootViewControllerAnimated:(BOOL)animated {
    [UIApplication sharedApplication].currentVC = self.viewControllers[0];
    return [self vc_popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)vc_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [UIApplication sharedApplication].currentVC = viewController;
   return [self vc_popToViewController:viewController animated:animated];
}

@end
