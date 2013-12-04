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

@implementation ScrollSystem

-(void)update:(float)dt
{
    Class scrollClass = [ScrollComponent class];
    Class renderClass = [RenderComponent class];
    
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:scrollClass];
    for (Entity *entity in entities) {
        ScrollComponent *scroll = (ScrollComponent*)[entity getComponentOfClass:scrollClass];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (!scroll || !render) continue;
        
        CGPoint pos = render.node.position;
        pos.y -= scroll.speed*dt;
        render.node.position = pos;
        
        if (scroll.shouldRepeat && (render.node.position.y <= scroll.repeatPoint)) {
            pos.y += scroll.repeatOffset;
            render.node.position = pos;
        }
    }
}

@end
