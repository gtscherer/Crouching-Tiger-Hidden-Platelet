//
//  MyScene.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/14/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

// Framework
#import "MyScene.h"
#import "EntityManager.h"
#import "EntityFactory.h"
#import "Entity.h"

// Systems
#import "VelocitySystem.h"
#import "CleanupSystem.h"
#import "ForceSystem.h"
#import "ScrollSystem.h"
#import "FreeMoveSystem.h"
#import "FollowSystem.h"
#import "CollisionSystem.h"
#import "HealthSystem.h"
#import "ShootSystem.h"

// Components
#import "FreeMoveComponent.h"
#import "ForceComponent.h"

#define kGestureThreshold 10.0f
#define kScoreHudName @"ScoreHUD"

@interface MyScene() {
    CGSize scrnSz;
    NSTimeInterval lastTime;
    CGFloat gestureStart;
    NSUInteger score;
    int planetTime;
    
    EntityManager *m_EntityManager;
    EntityFactory *m_EntFactory;
    
    VelocitySystem *m_RenderSys;
    CleanupSystem *m_CleanupSys;
    ForceSystem *m_ForceSys;
    ScrollSystem *m_ScrollSys;
    FreeMoveSystem *m_MoveSys;
    CollisionSystem *m_CollSys;
    FollowSystem *m_FollowSys;
    HealthSystem *m_HealthSys;
    ShootSystem *m_ShootSys;
    
    Entity *hero;
}
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        scrnSz = [[UIScreen mainScreen] bounds].size;
        
        m_EntityManager = [[EntityManager alloc] init];
        m_EntFactory    = [[EntityFactory alloc] initWithEntityManager:m_EntityManager nodeParent:self];
        
        m_RenderSys     = [[VelocitySystem alloc] initWithEntityManager:m_EntityManager];
        m_CleanupSys    = [[CleanupSystem alloc] initWithEntityManager:m_EntityManager];
        m_ForceSys      = [[ForceSystem alloc] initWithEntityManager:m_EntityManager];
        m_ScrollSys     = [[ScrollSystem alloc] initWithEntityManager:m_EntityManager];
        m_MoveSys       = [[FreeMoveSystem alloc] initWithEntityManager:m_EntityManager];
        m_FollowSys     = [[FollowSystem alloc] initWithEntityManager:m_EntityManager];
        m_CollSys       = [[CollisionSystem alloc] initWithEntityManager:m_EntityManager];
        m_HealthSys     = [[HealthSystem alloc] initWithEntityManager:m_EntityManager];
        m_ShootSys      = [[ShootSystem alloc] initWithEntityManager:m_EntityManager];
        
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
        bg.position = ccp(scrnSz.width/2, scrnSz.height/2);
        [self addChild:bg];
        
        CGPoint start = ccp(scrnSz.width/2, scrnSz.height/2.4);
        hero = [m_EntFactory createTestCreatureAtPoint:start];
        
        m_CollSys.toCheck = hero;
        m_CollSys.heroRef = hero;
        m_ShootSys.factory = m_EntFactory;
        
        start = ccp(scrnSz.width/2, scrnSz.height/8);
        [m_EntFactory scrollingBubbleAtPoint:start];
        
        planetTime = 0;
        gestureStart = 0.0f;
        score = 0.0f;
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
        scoreLabel.name = kScoreHudName;
        scoreLabel.fontSize = 20.0f;
        scoreLabel.fontColor = [SKColor whiteColor];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %06d", score];
        scoreLabel.position = ccp(scrnSz.width - scoreLabel.frame.size.width/2 - 20,
                                  scrnSz.height - (20 + scoreLabel.frame.size.height/2));
        [self addChild:scoreLabel];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    gestureStart = [[touches anyObject] locationInNode:self].x;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat curX = [[touches anyObject] locationInNode:self].x;
    CGFloat dX = curX - gestureStart;
    
    if (fabsf(dX) > kGestureThreshold) {
        CGPoint force = ccpMult((CGPoint){1, 0}, dX);
        ForceComponent *forceC = [[ForceComponent alloc] initWithForce:force];
        [m_EntityManager addComponent:forceC toEntity:hero];
        return;
    }
    
//    MoveComponent *move = (MoveComponent*)[hero getComponentOfClass:[MoveComponent class]];
//    if (move.direction == DirectionUp) {
//        move.accelVec = ccp(move.accelVec.x, ConstGravity);
//        move.direction = DirectionDown;
//        move.goodToScroll = FALSE;
//    }
//    else {
//        move.accelVec = ccp(move.accelVec.x, ConstFloatSpd);
//        move.direction = DirectionUp;
//    }
}

- (void)createTempItemAtPoint:(CGFloat)y
{
    CGFloat randX = arc4random() % 320;
    CGPoint pt = ccp(randX, y);
    
    Entity *ent;
    if (arc4random() % 4 != 0) {
        ent = [m_EntFactory scrollingBubbleAtPoint:pt];
    }
    else {
        ent = [m_EntFactory scrollingForceShooterAtPoint:pt];
    }
}

-(void)update:(CFTimeInterval)currentTime
{
    // Handle time delta.
    CFTimeInterval dt = currentTime - lastTime;
    if (dt > 1) dt = 1.0 / 60.0;
    lastTime = currentTime;
    
    planetTime++;

    FreeMoveComponent *move = (FreeMoveComponent*)[hero getComponentOfClass:[FreeMoveComponent class]];
    m_ScrollSys.active = move.goodToScroll;
    m_ShootSys.active = move.goodToScroll;
    
    if (m_ScrollSys.active) {
        score += 4;
        
        SKLabelNode *scoreLabel = (SKLabelNode*)[self childNodeWithName:kScoreHudName];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %06d", score];
        
        if (planetTime >= 30) {
            [self createTempItemAtPoint:scrnSz.height+50];
            planetTime = 0;
        }
    }
    
    [m_MoveSys update:dt];
    [m_ForceSys update:dt];
    [m_FollowSys update:dt];
    [m_ScrollSys update:dt];
    [m_ShootSys update:dt];
    [m_CollSys update:dt];
    [m_HealthSys update:dt];
    [m_RenderSys update:dt];
    [m_CleanupSys update:dt];
}

@end
