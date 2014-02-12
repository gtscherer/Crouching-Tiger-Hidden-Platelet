//
//  ForceSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "ForceSystem.h"
#import "VelocityComponent.h"
#import "ForceComponent.h"

@interface ForceSystem() {
    Class veloClass;
    Class forceClass;
}
@end

@implementation ForceSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        veloClass = [VelocityComponent class];
        forceClass = [ForceComponent class];
    }
    return self;
}

-(void)update:(float)dt
{
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:forceClass];
    for (Entity *entity in entities) {
        ForceComponent *force = (ForceComponent*)[entity getComponentOfClass:forceClass];
        VelocityComponent *velocity = (VelocityComponent*)[entity getComponentOfClass:veloClass];
        
        if (!force || !velocity) continue;
//        if (!force.useNow) continue;
        
        // Add immediate force, and then remove the component
        velocity.velocity = ccpAdd(velocity.velocity, force.force);
        [m_EntManager removeComponent:force fromEntity:entity];
    }
}

@end
