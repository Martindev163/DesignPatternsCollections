//
//  AttackHandler.m
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//防具

#import "AttackHandler.h"

@implementation AttackHandler

@synthesize nextAttackHandler = nextAttackHandler_;

-(void)handleAttack:(Attack *)attack
{
    [nextAttackHandler_ handleAttack:attack];
}

@end
