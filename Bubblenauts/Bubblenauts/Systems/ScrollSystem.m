//
//  ScrollSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/3/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "ScrollSystem.h"
#import "ScrollComponent.h"
#import "RenderComponent.h"

@import SpriteKit;

@interface ScrollSystem () {
    Class scrollClass;
    Class renderClass;
}
@end

@implementation ScrollSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        scrollClass = [ScrollComponent class];
        renderClass = [RenderComponent class];
    }
    return self;
}

-(void)update:(float)dt
{
    if (!self.active) return;
    
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:scrollClass];
    for (Entity *entity in entities) {
        ScrollComponent *scroll = (ScrollComponent*)[entity getComponentOfClass:scrollClass];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (!scroll || !render) continue;
        
        CGPoint pos = render.node.position;
        pos.y -= scroll.vector.y * dt;
        
        if (scroll.direction == DirectionLeft) pos.x -= scroll.vector.x * dt;
        if (scroll.direction == DirectionRight) pos.x += scroll.vector.x * dt;

        render.node.position = pos;
        
        if (scroll.shouldRepeat) {
            if (render.node.position.y <= scroll.repeatPoint) {
                pos.y += scroll.repeatOffset;
                render.node.position = pos;
            }
        }
    }
}

@end
