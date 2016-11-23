//
//  Avatar.m
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "Avatar.h"

@implementation Avatar

-(void)handleAttack:(Attack *)attack
{
    //实际损伤点数取决于攻击类型
    NSLog(@"我被%@攻击到了",[attack class]);
}

@end
