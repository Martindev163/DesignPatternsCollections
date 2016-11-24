//
//  FlowerFactory.h
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/24.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kAnemone,
    kCosmos,
    kGerberas,
    kHollyhock,
    kJasmine,
    kZinnia,
    kTotalNumberOfFlowerTypes
} FlowerType;

@interface FlowerFactory : NSObject
{
    @private
    NSMutableDictionary *flowerPool_;
}

-(UIView *)flowerViewWithType:(FlowerType)type;
@end
