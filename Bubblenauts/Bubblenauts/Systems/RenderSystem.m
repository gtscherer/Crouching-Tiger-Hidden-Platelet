//
//  RenderSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "RenderSystem.h"
#import "VelocityComponent.h"
#import "RenderComponent.h"
#import "CGPointExtension.h"
#import "CCSprite.h"

@implementation RenderSystem

-(void)update:(float)dt
{
    Class veloClass = [VelocityComponent class];
    Class rendClass = [RenderComponent class];
    
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:veloClass];
    for (Entity *entity in entities) {
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:rendClass];
        VelocityComponent *velocity = (VelocityComponent*)[entity getComponentOfClass:veloClass];
        
        if (!render || !velocity) continue;
        
        // Integrate velocity to get pos, and set it
        CGPoint stepVel = ccpMult(velocity.velocity, dt);
        render.node.position = ccpAdd(render.node.position, stepVel);
    }
}

-(void)dealloc
{
    [super dealloc];
}

@end
