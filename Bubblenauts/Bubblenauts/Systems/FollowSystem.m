//
//  FollowSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/27/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "FollowSystem.h"
#import "FollowComponent.h"
#import "RenderComponent.h"

@import SpriteKit;

@interface FollowSystem () {
    Class followClass;
    Class renderClass;
}
@end

@implementation FollowSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        followClass = [FollowComponent class];
        renderClass = [RenderComponent class];
    }
    return self;
}

-(void)update:(float)dt
{
    if (!self.active) return;
    
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:followClass];
    for (Entity *entity in entities) {
        FollowComponent *follow = (FollowComponent*)[entity getComponentOfClass:followClass];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        RenderComponent *toFollow = (RenderComponent*)[follow.toFollow getComponentOfClass:renderClass];
        
        if (!follow || !render || !toFollow) continue;
        
        render.node.position = toFollow.node.position;
    }
}

@end
