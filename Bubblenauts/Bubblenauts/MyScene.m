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
#import "RenderSystem.h"
#import "CleanupSystem.h"
#import "ForceSystem.h"
#import "ScrollSystem.h"
#import "MoveSystem.h"
#import "FollowSystem.h"
#import "CollisionSystem.h"

// Components
#import "MoveComponent.h"
#import "ForceComponent.h"

#define kGestureThreshold 10.0f

@interface MyScene() {
    CGSize scrnSz;
    NSTimeInterval lastTime;
    CGFloat gestureStart;
    int planetTime;
    
    EntityManager *m_EntityManager;
    EntityFactory *m_EntFactory;
    
    RenderSystem *m_RenderSys;
    CleanupSystem *m_CleanupSys;
    ForceSystem *m_ForceSys;
    ScrollSystem *m_ScrollSys;
    MoveSystem *m_MoveSys;
    CollisionSystem *m_CollSys;
    FollowSystem *m_FollowSys;
    
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
        
        m_RenderSys     = [[RenderSystem alloc] initWithEntityManager:m_EntityManager];
        m_CleanupSys    = [[CleanupSystem alloc] initWithEntityManager:m_EntityManager];
        m_ForceSys      = [[ForceSystem alloc] initWithEntityManager:m_EntityManager];
        m_ScrollSys     = [[ScrollSystem alloc] initWithEntityManager:m_EntityManager];
        m_MoveSys       = [[MoveSystem alloc] initWithEntityManager:m_EntityManager];
        m_FollowSys     = [[FollowSystem alloc] initWithEntityManager:m_EntityManager];
        m_CollSys       = [[CollisionSystem alloc] initWithEntityManager:m_EntityManager];
        
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
        bg.position = ccp(scrnSz.width/2, scrnSz.height/2);
        [self addChild:bg];
        
        CGPoint start = ccp(scrnSz.width/2, scrnSz.height/2.4);
        hero = [m_EntFactory createTestCreatureAtPoint:start];
        m_CollSys.toCheck = hero;
        
        start = ccp(scrnSz.width/2, scrnSz.height/8);
        [m_EntFactory scrollingBubbleAtPoint:start];
        
        planetTime = 0;
        gestureStart = 0.0f;
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

- (void)createTempBubbleAtPoint:(CGFloat)y
{
    CGFloat randX = arc4random() % 320;
    [m_EntFactory scrollingBubbleAtPoint:CGPointMake(randX, y)];
}

-(void)update:(CFTimeInterval)currentTime
{
    // Handle time delta.
    CFTimeInterval dt = currentTime - lastTime;
    if (dt > 1) dt = 1.0 / 60.0;
    lastTime = currentTime;
    
    planetTime++;

    MoveComponent *move = (MoveComponent*)[hero getComponentOfClass:[MoveComponent class]];
    m_ScrollSys.active = move.goodToScroll;
    if (m_ScrollSys.active) {
        if (planetTime >= 30) {
            [self createTempBubbleAtPoint:scrnSz.height+50];
            planetTime = 0;
        }
    }
    
    [m_MoveSys update:dt];
    [m_ForceSys update:dt];
    [m_FollowSys update:dt];
    [m_ScrollSys update:dt];
    [m_CollSys update:dt];
    [m_RenderSys update:dt];
    [m_CleanupSys update:dt];
}

@end
