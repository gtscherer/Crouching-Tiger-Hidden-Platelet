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
    
    Entity *toRemove;
    UIColor *dangerColor;
    UIColor *deathColor;
}
@end

@implementation HealthSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        healthClass = [HealthComponent class];
        renderClass = [RenderComponent class];
        
        dangerColor = [[UIColor orangeColor] colorWithAlphaComponent:0.3];
        deathColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
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
            health.health -= (4*dt);
            CGFloat thresh = health.popThreshold;
            
            CGFloat h = health.health*.01;
            render.node.xScale = h;
            render.node.yScale = h;
            
            if (health.health <= (thresh + 30) && health.health > (thresh + 15)) {
                render.node.color = dangerColor;
                render.node.colorBlendFactor = 0.4;
            }
            else if (health.health <= thresh + 15) {
                render.node.color = deathColor;
                render.node.colorBlendFactor = 0.4;
            }
            else {
                render.node.color = nil;
                render.node.colorBlendFactor = 0.0;
            }
            
            // Assuming only one bubble at a time has health, this can only happen once
            if (health.health <= thresh) {
                toRemove = entity;
                break;
            }
            
//            render.node.color = [UIColor redColor];
//            render.node.colorBlendFactor = 1/health.health*30;
        }
    }
    
    if (toRemove) {
        RenderComponent *render = (RenderComponent*)[toRemove getComponentOfClass:renderClass];
        
        [render.node removeFromParent];
        [m_EntManager removeEntityFromGame:toRemove];
        toRemove = nil;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:BubblePoppedHealth object:nil];
    }
//    NSUInteger i, count = [toRemove count];
//    for (i = 0; i < count; i++) {
//        Entity *entity = toRemove[i];
//        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
//        
//        if (render) [render.node removeFromParent];
//        [m_EntManager removeEntityFromGame:entity];
//    }
//    
//    [toRemove removeAllObjects];
}

@end
