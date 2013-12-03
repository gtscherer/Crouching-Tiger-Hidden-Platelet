//
//  GravitySystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "GravitySystem.h"
#import "GravityComponent.h"
#import "VelocityComponent.h"
#import "CGPointExtension.h"

@implementation GravitySystem

-(void)update:(float)dt
{
    Class gravClass = [GravityComponent class];
    Class veloClass = [VelocityComponent class];
    
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:gravClass];
    for (Entity *entity in entities) {
        GravityComponent *gravity = (GravityComponent*)[entity getComponentOfClass:gravClass];
        VelocityComponent *velocity = (VelocityComponent*)[entity getComponentOfClass:veloClass];
        
        if (!gravity || !velocity) continue;
        
        // Integrate accel due to grav to get velocity, and
        CGPoint gravStep = ccpMult(gravity.gravity, dt);
        velocity.velocity = ccpAdd(velocity.velocity, gravStep);
    }
}

-(void)dealloc
{
    [super dealloc];
}

@end
