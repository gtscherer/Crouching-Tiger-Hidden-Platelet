//
//  MovementSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/23/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "MoveSystem.h"
#import "MoveComponent.h"
#import "RenderComponent.h"
#import "VelocityComponent.h"

@import SpriteKit;

@interface MoveSystem () {
    Class moveClass;
    Class renderClass;
    Class veloClass;
}
@end

@implementation MoveSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        moveClass = [MoveComponent class];
        renderClass = [RenderComponent class];
        veloClass = [VelocityComponent class];
    }
    return self;
}

- (void)update:(float)dt
{
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:moveClass];
    
    for (Entity *entity in entities) {
        MoveComponent *move = (MoveComponent*)[entity getComponentOfClass:moveClass];
        RenderComponent *rend = (RenderComponent*)[entity getComponentOfClass:renderClass];
        VelocityComponent *velo = (VelocityComponent*)[entity getComponentOfClass:veloClass];
        
        if (!move || !rend || !velo) continue;
        
        if (move.direction == DirectionUp) {
            if (rend.node.position.y >= move.stopY) {
                velo.velocity = ccp(velo.velocity.x, 0.0f);
                move.goodToScroll = TRUE;
                continue;
            }
        }
        
        CGPoint stepVel = ccpMult(move.accelVec, dt);
        velo.velocity = ccpAdd(velo.velocity, stepVel);
        
        if (velo.velocity.y >= maxFloatSpeed)
            velo.velocity = ccp(velo.velocity.x, maxFloatSpeed);
        
        if (velo.velocity.y <= maxFallSpeed)
            velo.velocity = ccp(velo.velocity.x, maxFallSpeed);
    }
}
@end
