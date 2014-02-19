//
//  HealthSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/29/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "HealthSystem.h"
#import "HealthComponent.h"
#import "RenderComponent.h"

@import SpriteKit;

@interface HealthSystem () {
    Class healthClass;
    Class renderClass;
}
@end

@implementation HealthSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        healthClass = [HealthComponent class];
        renderClass = [RenderComponent class];
    }
    return self;
}

-(void)update:(float)dt
{
    if (!self.active) return;
    
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:healthClass];
    for (Entity *entity in entities) {
        HealthComponent *health = (HealthComponent*)[entity getComponentOfClass:healthClass];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (!health || !render) continue;
        
        if (entity.type == BubbleType) {
            health.health -= (5*dt);
            
//            NSLog(@"Health is %f", health.health);
            
            CGFloat h = health.health*.01;
            render.node.xScale = h;
            render.node.yScale = h;
            
//            NSLog(@"Scale is %f, %f", render.node.xScale, render.node.yScale);
        }
    }
}

@end
