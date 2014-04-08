//
//  CollisionSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/15/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "CollisionSystem.h"
#import "Entity.h"
#import "CollisionComponent.h"
#import "RenderComponent.h"
#import "FreeMoveComponent.h"
#import "FollowComponent.h"
#import "ScrollComponent.h"
#import "HealthComponent.h"
#import "ForceComponent.h"

@import SpriteKit;

@interface CollisionSystem () {
    Class collisClass;
    Class renderClass;
    
    NSMutableArray *toRemove;
}
@end

@implementation CollisionSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        collisClass = [CollisionComponent class];
        renderClass = [RenderComponent class];
        
        toRemove = [NSMutableArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bubblePopped:) name:BubblePoppedHealth object:nil];
    }
    return self;
}

- (void)bubblePopped:(NSNotification*)aNotif {
    self.toCheck = nil;
    
    FreeMoveComponent *move = (FreeMoveComponent*)[self.heroRef getComponentOfClass:[FreeMoveComponent class]];
    move.accelVec = ccp(move.accelVec.x, ConstGravity);
    move.direction = DirectionDown;
    move.goodToScroll = FALSE;
    
    self.toCheck = self.heroRef;
}

-(void)update:(float)dt
{
    if (!self.active) return;
    
    if (self.toCheck.type == HeroType) {
        [self checkHeroForCollisions];
    }
    else if (self.toCheck.type == BubbleType) {
        [self checkBubbleForCollisions];
    }
}

- (void)checkHeroForCollisions
{
    RenderComponent *heroRender = (RenderComponent*)[self.toCheck getComponentOfClass:renderClass];
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:collisClass];
    
    for (Entity *entity in entities) {
        if (entity == self.toCheck) continue;
        
        CollisionComponent *coll = (CollisionComponent*)[entity getComponentOfClass:collisClass];
        RenderComponent *oRender = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (!coll || !oRender) continue;
        
        if ([heroRender.node intersectsNode:oRender.node]) {
            if (entity.type == BubbleType) {
                FreeMoveComponent *move = (FreeMoveComponent*)[self.toCheck getComponentOfClass:[FreeMoveComponent class]];
                move.accelVec = ccp(move.accelVec.x, ConstFloatSpd);
                move.direction = DirectionUp;
                
                // Add some follow component for the bubble to follow the hero
                FollowComponent *follow = [[FollowComponent alloc] initWithFollowNode:self.toCheck];
                [m_EntManager addComponent:follow toEntity:entity];
                
                // Add a health component, as the bubble is now linked to the hero!
                HealthComponent *health = [[HealthComponent alloc] initWithHealth:125.0f];
                health.popThreshold = 70.0f;
                [m_EntManager addComponent:health toEntity:entity];
                
                ScrollComponent *scroll = (ScrollComponent*)[entity getComponentOfClass:[ScrollComponent class]];
                if (scroll) [m_EntManager removeComponent:scroll fromEntity:entity];
                
                self.toCheck = entity;
                return; // Only one collision at a time
            }
            
            if (entity.type == EnemyType) {
                self.active = FALSE;
                [[NSNotificationCenter defaultCenter] postNotificationName:GameOverCondition object:nil];
                return; // We need to exit ASAP, only one collision at a time
            }
        }
    }
}

- (void)checkBubbleForCollisions
{
    RenderComponent *bubRender = (RenderComponent*)[self.toCheck getComponentOfClass:renderClass];
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:collisClass];
    
    for (Entity *entity in entities) {
        if (entity == self.toCheck) continue;
        
        CollisionComponent *coll = (CollisionComponent*)[entity getComponentOfClass:collisClass];
        RenderComponent *oRender = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (!coll || !oRender) continue;
        
        if ([bubRender.node intersectsNode:oRender.node]) {
            // If bubble collides with other bubble, increase the bubble's health/size
            if (entity.type == BubbleType) {
                HealthComponent *health = (HealthComponent*)[self.toCheck getComponentOfClass:[HealthComponent class]];
                health.health += 15;
                if (health.health >= 175) health.health = 175;
                [toRemove addObject:entity];
                break;
            }
            
            if (entity.type == ForceType) {
                ScrollComponent *scroll = (ScrollComponent*)[entity getComponentOfClass:[ScrollComponent class]];
                CGFloat x = (scroll.direction == DirectionRight) ? scroll.vector.x : -scroll.vector.x;
                
                // Fixed a crash where input would conflict with this (can't add duplicate components)
//                ForceComponent *existing = (ForceComponent*)[self.heroRef getComponentOfClass:[ForceComponent class]];
//                if (existing) [m_EntManager removeComponent:existing fromEntity:self.heroRef];
                
                ForceComponent *toApply = [[ForceComponent alloc] initWithForce:ccp(x, 0.0)];
                [m_EntManager addComponent:toApply toEntity:self.heroRef];
                [toRemove addObject:entity];
                break;
            }
            
            // If bubble collides with platform/enemy, pop.
            if (entity.type == EnemyType) {
                Entity *bub = self.toCheck;
                [toRemove addObject:bub];
                [toRemove addObject:entity];
                self.toCheck = nil;
                
                FreeMoveComponent *move = (FreeMoveComponent*)[self.heroRef getComponentOfClass:[FreeMoveComponent class]];
                move.accelVec = ccp(move.accelVec.x, ConstGravity);
                move.direction = DirectionDown;
                move.goodToScroll = FALSE;
                
                self.toCheck = self.heroRef;
                break;
            }
        }
    }
    
    NSUInteger i, count = [toRemove count];
    for (i = 0; i < count; i++) {
        Entity *entity = toRemove[i];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (render) [render.node removeFromParent];
        [m_EntManager removeEntityFromGame:entity];
    }
    
    [toRemove removeAllObjects];
}

@end
