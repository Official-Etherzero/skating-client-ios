//
//  WDTabbarController.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/9.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "WDTabbarController.h"
#import "RDVTabBarController.h"
#import "WDWalletViewController.h"
#import "WDDiscoverViewController.h"
#import "WDMarketController.h"
#import "YYNodeViewController.h"
#import "YYMineController.h"

@implementation WDTabbarController

+ (UIViewController *)setupViewControllersWithIndex:(NSUInteger)index {
//    UIViewController *walletVC = [[WDWalletViewController alloc] init];
//    UIViewController *naviWalletVC = [[UINavigationController alloc] initWithRootViewController:walletVC];
    
//    WDMarketController *marketVC = [[WDMarketController alloc] init];
//    UIViewController *naviMarketVC = [[UINavigationController alloc] initWithRootViewController: marketVC];
//
//    WDDiscoverViewController *disCoverVC = [[WDDiscoverViewController alloc] init];
//    UIViewController *navDisCoverVC = [[UINavigationController alloc] initWithRootViewController:disCoverVC];
    
    YYNodeViewController *nodeVC = [[YYNodeViewController alloc] init];
    UIViewController *navNodeVC = [[UINavigationController alloc] initWithRootViewController:nodeVC];
    
    YYMineController *mineVC = [[YYMineController alloc] init];
    UIViewController *navMineVC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[/*naviWalletVC,*/
                                           navNodeVC,
                                           navMineVC]];
    [tabBarController.tabBar setHeight:49];
    [tabBarController setSelectedIndex:index];
    return tabBarController;
}

@end
