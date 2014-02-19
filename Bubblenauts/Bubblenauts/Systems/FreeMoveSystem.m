//
//  MovementSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/23/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "FreeMoveSystem.h"
#import "FreeMoveComponent.h"
#import "RenderComponent.h"
#import "VelocityComponent.h"

@import SpriteKit;

@interface FreeMoveSystem () {
    Class moveClass;
    Class renderClass;
    Class veloClass;
}
@end

@implementation FreeMoveSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        moveClass = [FreeMoveComponent class];
        renderClass = [RenderComponent class];
        veloClass = [VelocityComponent class];
    }
    return self;
}

- (void)update:(float)dt
{
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:moveClass];
    
    for (Entity *entity in entities) {
        FreeMoveComponent *move = (FreeMoveComponent*)[entity getComponentOfClass:moveClass];
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
        
        if (velo.velocity.y >= MaxFloatSpeed)
            velo.velocity = ccp(velo.velocity.x, MaxFloatSpeed);
        
        if (velo.velocity.y <= MaxFallSpeed)
            velo.velocity = ccp(velo.velocity.x, MaxFallSpeed);
    }
}
@end
