//
//  RPGViewController.m
//  DesignPatternsCollections
//
//  Created by 马浩哲 on 16/11/23.
//  Copyright © 2016年 junanxin. All rights reserved.
//

#define RPGViewLeftMargin 20
#define RPGViewBtnWidth   100
#define RPGViewBtnHeight  44
#define RPGViewBtnMargin  20
#define RPGViewBloodAllWidth (kDeviceWidth - 40)
#define RPGViewBloodBlockWidth RPGViewBloodAllWidth/10

#import "RPGViewController.h"
#import "Attack.h"
#import "SwordAttack.h"
#import "MagicFireAttack.h"
#import "LightningAttack.h"
#import "AttackHandler.h"
#import "MetalArmor.h"
#import "CrystalShield.h"
#import "Avatar.h"
#import <objc/runtime.h>

typedef NS_ENUM(int, AttackType){
    SwordAttackType = 0,
    MagicFireAttackType,
    LightningAttackType,
    resurrectionType,
};

@interface RPGViewController ()
{
    NSInteger _bloodCount;//血量
    BOOL _hasShowAlert;//是否显示死亡提示
}

//血条
@property (nonatomic, strong) UIView *bloodBGView;
@property (nonatomic, strong) UIView *bloodView;

@property (nonatomic, strong) UIButton *swordAttackBtn;//刀剑攻击
@property (nonatomic, strong) UIButton *magicFireAttackBtn;//魔法攻击
@property (nonatomic, strong) UIButton *lightningAttackBtn;//闪电攻击
@property (nonatomic, strong) UIButton *resurrectionBtn;//满血复活

//攻击--》水晶盾--》金属盾--》人
@property (nonatomic, strong) AttackHandler *avatar;//人物
@property (nonatomic, strong) AttackHandler *metalArmored;//金属护盾
@property (nonatomic, strong) AttackHandler *crystalShield;//水晶盾

//攻击
@property (nonatomic, strong) Attack *swordAttack;//刀剑攻击
@property (nonatomic, strong) Attack *magicFireAttack;//魔法攻击
@property (nonatomic, strong) Attack *lightningAttack;//雷电攻击

@end

@implementation RPGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"责任链模式";
    _bloodCount = 10;
    //初始化人物属性
    [self InitializeAvataAttribute];
    //加载控件
    [self loadSubViews];
}


#pragma mark - 初始化人物属性
-(void)InitializeAvataAttribute
{
    //创建人物
    _avatar = [[Avatar alloc] init];
    
    //穿金属甲
    _metalArmored = [[MetalArmor alloc] init];
    [_metalArmored setNextAttackHandler:_avatar];
    
    //穿水晶盾
    _crystalShield = [[CrystalShield alloc] init];
    [_crystalShield setNextAttackHandler:_metalArmored];
    
    _swordAttack = [[SwordAttack alloc] init];
    _magicFireAttack = [[MagicFireAttack alloc] init];
    _lightningAttack = [[LightningAttack alloc] init];
}

#pragma mark - 加载控件
-(void)loadSubViews
{
    _bloodBGView = [[UIView alloc] initWithFrame:CGRectMake(20, 84, kDeviceWidth- 40, 20)];
    _bloodBGView.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:_bloodBGView];
    
    _bloodView = [[UIView alloc] initWithFrame:CGRectMake(20, 84, kDeviceWidth-40, 20)];
    _bloodView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_bloodView];
    
    _swordAttackBtn = [self addAttackBtnWithTitle:@"刀剑攻击" BottomWithView:_bloodView AttackType:SwordAttackType];
    [self.view addSubview:_swordAttackBtn];
    
    _magicFireAttackBtn = [self addAttackBtnWithTitle:@"魔法攻击" BottomWithView:_swordAttackBtn AttackType:MagicFireAttackType];
    [self.view addSubview:_magicFireAttackBtn];
    
    _lightningAttackBtn = [self addAttackBtnWithTitle:@"闪电攻击" BottomWithView:_magicFireAttackBtn AttackType:LightningAttackType];
    [self.view addSubview:_lightningAttackBtn];
    
    _resurrectionBtn = [self addAttackBtnWithTitle:@"满血复活" BottomWithView:_lightningAttackBtn AttackType:resurrectionType];
    [self.view addSubview:_resurrectionBtn];
}

#pragma mark - 初始化Btn
-(UIButton *)addAttackBtnWithTitle:(NSString *)AttackTypeStr BottomWithView:(UIView *)view AttackType:(AttackType)attackType
{
    
    UIButton *attackBtn = [[UIButton alloc] initWithFrame:CGRectMake(RPGViewLeftMargin, view.bottom + RPGViewBtnMargin, RPGViewBtnWidth, RPGViewBtnHeight)];
    [attackBtn setTitle:AttackTypeStr forState:UIControlStateNormal];
    attackBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [attackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    attackBtn.backgroundColor = [UIColor blueColor];
    [attackBtn addTarget:self action:@selector(AttackActionDealWith:) forControlEvents:UIControlEventTouchUpInside];
    //添加关联参数
    objc_setAssociatedObject(attackBtn, @"attackType", [NSNumber numberWithInt:attackType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return attackBtn;
}

#pragma mark - 攻击事件设置
-(void)AttackActionDealWith:(UIButton *)sender
{
    AttackType attackType = [(NSNumber *)objc_getAssociatedObject(sender, @"attackType") intValue];
    if (_bloodCount > 0)
    {
        switch (attackType)
        {
            case SwordAttackType:
            {
                [_crystalShield handleAttack:_swordAttack];
                _bloodCount -= 1;
            }
                break;
            case MagicFireAttackType:
            {
                [_crystalShield handleAttack:_magicFireAttack];
                _bloodCount -= 2;
            }
                break;
            case LightningAttackType:
            {
                [_crystalShield handleAttack:_lightningAttack];
                _bloodCount -= 5;
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        if (attackType == resurrectionType) {
            _bloodCount = 10;
        }
        else
        {
            NSLog(@"人物已牺牲");
        }
    }
    [self bloodChangeWithBloodCount:_bloodCount];
}

#pragma mark - 设置血条变化
-(void)bloodChangeWithBloodCount:(NSInteger)bloodCount
{
    if (bloodCount>0)
    {
        [UIView animateWithDuration:1.0 animations:^{
            _bloodView.frame = CGRectMake(20+RPGViewBloodBlockWidth*(10-_bloodCount), _bloodView.top, RPGViewBloodBlockWidth*bloodCount, 20);
        }];
    }
    else
    {
        if (_hasShowAlert == NO) {
            UILabel *alertView = [[UILabel alloc] initWithFrame:CGRectMake(20, _resurrectionBtn.bottom + 100, RPGViewBloodAllWidth, 40)];
            
            alertView.backgroundColor = [UIColor orangeColor];
            alertView.text = @"人物已经死亡";
            alertView.textAlignment = NSTextAlignmentCenter;
            alertView.font = [UIFont systemFontOfSize:14];
            alertView.alpha = 0.2;
            alertView.textColor = [UIColor whiteColor];
            [self.view addSubview:alertView];
            
            [UIView animateWithDuration:1.0 animations:^{
                _bloodView.frame = CGRectMake(20+ RPGViewBloodAllWidth, _bloodView.top, 0, 20);
                alertView.alpha = 1.0;
                _hasShowAlert = YES;
            }completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    alertView.alpha = 0.0;
                    [alertView removeFromSuperview];
                    _hasShowAlert = NO;
                });
            }];
        }
    }
}
@end
