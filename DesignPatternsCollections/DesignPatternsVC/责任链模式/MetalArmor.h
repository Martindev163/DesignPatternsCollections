//
//  MetalArmor.h
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//金属护甲

#import "AttackHandler.h"

@interface MetalArmor : AttackHandler

//重载方法(不是必须写)
-(void)handleAttack:(Attack *)attack;

@end
