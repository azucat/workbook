//
//  SpaceshipScene.m
//  Spiritus
//
//  Created by 村上幸雄 on 2014/02/05.
//  Copyright (c) 2014年 村上幸雄. All rights reserved.
//

#import "SpaceshipScene.h"

@interface SpaceshipScene ()
@property (assign, nonatomic) BOOL  contentCreated;
@end

@implementation SpaceshipScene

@synthesize contentCreated = _contentCreated;

-(id)initWithSize:(CGSize)size
{
    DBGMSG(@"%s", __func__);
    if (self = [super initWithSize:size]) {
    }
    return self;
}

- (void)willMoveFromView:(SKView *)view
{
    DBGMSG(@"%s", __func__);
}

- (void)didMoveToView:(SKView *)view
{
    DBGMSG(@"%s", __func__);
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    DBGMSG(@"%s", __func__);
    self.backgroundColor = [SKColor blackColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    /* 宇宙船を配置 */
    SKSpriteNode *spaceship = [self newSpaceship];
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150);
    [self addChild:spaceship];
}

- (SKSpriteNode *)newSpaceship
{
    DBGMSG(@"%s", __func__);
    /* 宇宙船を生成 */
    SKSpriteNode *hull = [[SKSpriteNode alloc] initWithColor:[SKColor grayColor] size:CGSizeMake(64,32)];
    
    /* 宇宙船にライトをつける */
    SKSpriteNode *light1 = [self newLight];
    light1.position = CGPointMake(-28.0, 6.0);
    [hull addChild:light1];
    
    /* 宇宙船にライトをつける */
    SKSpriteNode *light2 = [self newLight];
    light2.position = CGPointMake(28.0, 6.0);
    [hull addChild:light2];

    /* 宇宙船を動かす */
    SKAction *hover = [SKAction sequence:@[
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:100 y:50.0 duration:1.0],
                                           [SKAction waitForDuration:1.0],
                                           [SKAction moveByX:-100.0 y:-50 duration:1.0]]];
    [hull runAction: [SKAction repeatActionForever:hover]];
    
    return hull;
}

- (SKSpriteNode *)newLight
{
    DBGMSG(@"%s", __func__);
    /* ライトを生成 */
    SKSpriteNode *light = [[SKSpriteNode alloc] initWithColor:[SKColor yellowColor] size:CGSizeMake(8,8)];
    
    /* 点滅させる */
    SKAction *blink = [SKAction sequence:@[
                                           [SKAction fadeOutWithDuration:0.25],
                                           [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    [light runAction: blinkForever];
    
    return light;
}

@end