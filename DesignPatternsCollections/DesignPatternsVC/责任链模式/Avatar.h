//
//  Avatar.h
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//游戏人物

#import "AttackHandler.h"

@interface Avatar : AttackHandler

-(void)handleAttack:(Attack *)attack;

@end
