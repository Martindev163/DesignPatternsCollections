//
//  CoordinatingController.h
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/25.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    kButtonTagFirst,
    kButtonTagSecond,
    kButtonTagThird
}ButtonTag;

@interface PatternRootViewController : UITabBarController

+(PatternRootViewController *)sharedInstance;
@end
