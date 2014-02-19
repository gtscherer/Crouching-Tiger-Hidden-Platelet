//
//  ShootSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 2/10/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "ShootSystem.h"
#import "EntityFactory.h"
#import "ShootComponent.h"
#import "RenderComponent.h"

@import SpriteKit;

@interface ShootSystem() {
    Class shootClass;
    Class renderClass;
    CGFloat time;
}
@end

@implementation ShootSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        shootClass = [ShootComponent class];
        renderClass = [RenderComponent class];
        time = 0.0;
    }
    return self;
}

- (void)update:(float)dt
{
    if (!self.active) return;
    
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:shootClass];
    for (Entity *entity in entities) {
        ShootComponent *shoot = (ShootComponent*)[entity getComponentOfClass:shootClass];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (!shoot) continue;
        time += dt;
        
        if (time >= shoot.frequency) {
            //shoot a bullet!
            [self.factory movingForceAtPoint:render.node.position];
            time = 0.0;
        }
    }
}

@end
