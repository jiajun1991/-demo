//
//  UIApplication+LJApplication.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "UIApplication+LJApplication.h"

@implementation UIApplication (LJApplication)
+(UIViewController *)rootViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return window.rootViewController;
}
+(UIViewController *)currentViewController
{
    UIViewController *controller = [UIApplication rootViewController];
    //通过循环一层一层往下找
    while (YES) {
        //先判断是否有present的控制器
        if(controller.presentedViewController){
            //有的话直接拿出控制器，省去多余的判断
            controller = controller.presentedViewController;
        }else{
            if([controller isKindOfClass:[UINavigationController class]]){
                //如果是NavigationController，取最后一个控制器（当前）
                controller = [controller.childViewControllers lastObject];
            }else if ([controller isKindOfClass:[UITabBarController class]]){
                //如果是TabBarController，取当前控制器
                UITabBarController *tabBarController = (UITabBarController *)controller;
                controller = tabBarController.selectedViewController;
            }else{
                if(controller.childViewControllers.count > 0){
                    //如果是普通控制器，找childViewControllers最后一个
                    controller = [controller.childViewControllers lastObject];
                }else{
                    //没有present，没有childViewController，则表示当前控制器
                    return controller;
                }
            }
        }
    }
}
@end
