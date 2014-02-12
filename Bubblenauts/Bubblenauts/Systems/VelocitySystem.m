//
//  RenderSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "VelocitySystem.h"
#import "VelocityComponent.h"
#import "RenderComponent.h"

@import SpriteKit;

@interface VelocitySystem () {
    Class veloClass;
    Class rendClass;
    
    CGSize scrnSz;
}
@end

@implementation VelocitySystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        veloClass = [VelocityComponent class];
        rendClass = [RenderComponent class];
        
        scrnSz = [[UIScreen mainScreen] bounds].size;
    }
    return self;
}

-(void)update:(float)dt
{
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:veloClass];
    for (Entity *entity in entities) {
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:rendClass];
        VelocityComponent *velocity = (VelocityComponent*)[entity getComponentOfClass:veloClass];
        
        if (!render || !velocity) continue;
        
        // Integrate velocity to get pos, and set it
        CGPoint stepVel = ccpMult(velocity.velocity, dt);
//        if (CGPointEqualToPoint(stepVel, CGPointZero)) continue;
        
        render.node.position = ccpAdd(render.node.position, stepVel);
        
        if (render.node.position.x >= (scrnSz.width - render.node.size.width)) {
            CGPoint pos = ccp(scrnSz.width - render.node.size.width, render.node.position.y);
            render.node.position = pos;
            velocity.velocity = ccp(0, velocity.velocity.y);
        }
        
        if (render.node.position.x <= render.node.size.width) {
            CGPoint pos = ccp(render.node.size.width, render.node.position.y);
            render.node.position = pos;
            velocity.velocity = ccp(0, velocity.velocity.y);
        }
    }
}

@end
