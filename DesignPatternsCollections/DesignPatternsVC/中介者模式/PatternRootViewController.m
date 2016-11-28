//
//  CoordinatingController.m
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/25.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "PatternRootViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
@interface PatternRootViewController ()

@end

@implementation PatternRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"中介者模式";
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.tabBarItem.title = @"页面一";
    
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    secondVC.tabBarItem.title = @"页面二";
    
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    thirdVC.tabBarItem.title = @"页面三";
    
    self.viewControllers = @[firstVC,secondVC,thirdVC];
}

#pragma mark - 创建实例
+(PatternRootViewController *)sharedInstance
{
    static PatternRootViewController *sharedCoordinatingController = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedCoordinatingController = [[self alloc] init];
    });
    return sharedCoordinatingController;
}

@end
