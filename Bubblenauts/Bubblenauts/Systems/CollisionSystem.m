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
#import "MoveComponent.h"
#import "FollowComponent.h"
#import "ScrollComponent.h"

@import SpriteKit;

@interface CollisionSystem () {
    Class collisClass;
    Class renderClass;
}
@end

@implementation CollisionSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        collisClass = [CollisionComponent class];
        renderClass = [RenderComponent class];
    }
    return self;
}

-(void)update:(float)dt
{
    if (self.toCheck.type == HeroType) {
        // Check collision with naked node - would end up killing the character
        [self checkHeroForCollisions];
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
                MoveComponent *move = (MoveComponent*)[self.toCheck getComponentOfClass:[MoveComponent class]];
                move.accelVec = ccp(move.accelVec.x, ConstFloatSpd);
                move.direction = DirectionUp;
                
                // Add some follow component for the bubble to follow the hero
                FollowComponent *follow = [[FollowComponent alloc] initWithFollowNode:self.toCheck];
                [m_EntManager addComponent:follow toEntity:entity];
                
                ScrollComponent *scroll = (ScrollComponent*)[entity getComponentOfClass:[ScrollComponent class]];
                if (scroll) [m_EntManager removeComponent:scroll fromEntity:entity];
                
                self.toCheck = entity;
            }
        }
    }
}

- (void)checkBubbleCollisionWithEntities:(NSArray*)entities
{
    
}

@end
