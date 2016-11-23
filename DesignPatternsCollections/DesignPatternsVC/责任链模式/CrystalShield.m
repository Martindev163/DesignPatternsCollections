//
//  CrystalShield.m
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import "CrystalShield.h"
#import "MagicFireAttack.h"

@implementation CrystalShield

-(void)handleAttack:(Attack *)attack
{
    if ([attack isKindOfClass:[MagicFireAttack class]]) {
        NSLog(@"魔法攻击没有通过水晶盾牌");
    }
    else
    {
        NSLog(@"不能识别这种攻击：%@",[attack class]);
        [super handleAttack:attack];
    }
}

@end
