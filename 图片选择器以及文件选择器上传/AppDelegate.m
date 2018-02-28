//
//  AppDelegate.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "AppDelegate.h"
#import "PreviewViewController.h"
#import "UIApplication+LJApplication.h"
#import "Headerfile.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation
{
    PreviewViewController *previewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"previewVCID"];
    [[UIApplication currentViewController] presentViewController:previewVC animated:YES completion:nil];
    previewVC.url = url;
    NSLog(@"%@",url);
//    [displayController.label setText:sourceApplication];
    return YES;
}

#else
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    PreviewViewController *previewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"previewVCID"];
    [[UIApplication currentViewController] presentViewController:previewVC animated:YES completion:nil];
    previewVC.url = url;
//    [displayController.label setText:[options objectForKey:UIApplicationOpenURLOptionsSourceApplicationKey]];
    NSLog(@"%@",url);
    return YES;
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
