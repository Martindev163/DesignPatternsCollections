//
//  MetalArmor.m
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "MetalArmor.h"
#import "SwordAttack.h"

@implementation MetalArmor

-(void)handleAttack:(Attack *)attack
{
    if ([attack isKindOfClass:[SwordAttack class]]) {
        NSLog(@"攻击没有通过这个金属盔甲");
    }
    else
    {
        NSLog(@"不能识别这个攻击:%@",[attack class]);
        [super handleAttack:attack];
    }
}

@end
