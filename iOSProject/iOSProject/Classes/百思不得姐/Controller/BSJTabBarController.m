//
//  BSJTabBarController.m
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/5/11.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import "BSJTabBarController.h"
#import "BSJEssenceViewController.h"
#import "BSJNewViewController.h"
#import "BSJPublishViewController.h"
#import "BSJTrendViewController.h"
#import "BSJMeViewController.h"
#import "BSJTabBar.h"
#import "BSJGuidePushView.h"


@interface BSJTabBarController ()<UITabBarControllerDelegate>

@end

@implementation BSJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tabBar.tintColor = [UIColor redColor];
    
    [self setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, -3)] forKeyPath:LMJKeyPath(self, titlePositionAdjustment)];
    
    [self addTabarItems];
    [self addChildViewControllers];
    
    self.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //        if (![GVUserDefaults standardUserDefaults].isHaveBSJFirstLaunch) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:[BSJGuidePushView guidePushView]];
        //            BBUserDefault.isHaveBSJFirstLaunch = YES;
        //        }
    });
}

/**
 *  利用 KVC 把系统的 tabBar 类型改为自定义类型。覆盖父类方法
 */
- (void)setUpTabBar {
    
    BSJTabBar *tabBar = [[BSJTabBar alloc] init];
    
    LMJWeak(self);
    [tabBar setPublishBtnClick:^(BSJTabBar *tabBar, UIButton *publishBtn){
        
        BSJPublishViewController *publishVc = [[BSJPublishViewController alloc] init];
        
        //            @property (nonatomic,retain) UIViewController *popUpViewController;
        //            @property (nonatomic,assign) CGPoint popUpOffset;               //相对于弹出位置的偏移
        //            @property (nonatomic,assign) CGSize popUpViewSize;              //弹出视图的大小
        //            @property (nonatomic,assign) DDPopUpPosition popUpPosition;     //弹出视图的位置
        //            @property (nonatomic,assign) BOOL dismissWhenTouchBackground;   //是否允许点击背景dismiss
        //            @property (nonatomic,copy) DismissCallback dismissCallback;
        
        
        publishVc.popUpViewSize = kScreenSize;
        
        [weakself showPopUpViewController:publishVc animationType:DDPopUpAnimationTypeNone];
        
    }];
    
    [self setValue:tabBar forKeyPath:LMJKeyPath(self, tabBar)];
}

- (void)addChildViewControllers
{
    LMJNavigationController *one = [[LMJNavigationController alloc] initWithRootViewController:[[BSJEssenceViewController alloc] init]];
    
    LMJNavigationController *two = [[LMJNavigationController alloc] initWithRootViewController:[[BSJNewViewController alloc] init]];
    
    LMJNavigationController *four = [[LMJNavigationController alloc] initWithRootViewController:[[BSJTrendViewController alloc] init]];
    
    LMJNavigationController *five = [[LMJNavigationController alloc] initWithRootViewController:[[BSJMeViewController alloc] init]];
    
    self.viewControllers = @[one, two, four, five];
    
}

- (void)addTabarItems
{
    
    
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"精华",
                                                 CYLTabBarItemImage : @"tabBar_essence_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_essence_click_icon",
                                                 };
    
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"关注",
                                                  CYLTabBarItemImage : @"tabBar_friendTrends_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_friendTrends_click_icon",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"新帖",
                                                 CYLTabBarItemImage : @"tabBar_new_icon",
                                                 CYLTabBarItemSelectedImage : @"tabBar_new_click_icon",
                                                 };
    
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"我",
                                                  CYLTabBarItemImage : @"tabBar_me_icon",
                                                  CYLTabBarItemSelectedImage : @"tabBar_me_click_icon"
                                                  };
    
    self.tabBarItemsAttributes = @[
                                   firstTabBarItemsAttributes,
                                   thirdTabBarItemsAttributes,
                                   secondTabBarItemsAttributes,
                                   fourthTabBarItemsAttributes
                                   ];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

@end
