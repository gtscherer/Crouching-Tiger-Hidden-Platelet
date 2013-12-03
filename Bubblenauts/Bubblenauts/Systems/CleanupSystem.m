//
//  CleanupSystem.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "CleanupSystem.h"
#import "CleanupComponent.h"
#import "RenderComponent.h"
#import "CCSprite.h"

@implementation CleanupSystem

-(void)update:(float)dt
{
    Class cleanupClass = [CleanupComponent class];
    Class renderClass = [RenderComponent class];
    
    // There is a potential issue here. I fixed it, but it is probably not algorithmically
    // great.
    //
    // The issue here is simple - the "entities" array we get back is an address
    // reference to the entity manager's data store. So when we are in the middle
    // of enumerating it and have to delete an entity, we modify the collection that
    // we are currently iterating :(
    // So I instead find out who needs to be deleted, store a separate ref to them,
    // and then delete them outside of the enumeration. This way the collection is
    // only modified after it has been iterated
    NSArray *entities = [m_EntManager getAllEntitiesWithComponentClass:cleanupClass];
    NSMutableArray *toRemove = nil;
    
    for (Entity *entity in entities) {
        CleanupComponent *cleanup = (CleanupComponent*)[entity getComponentOfClass:cleanupClass];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (!cleanup || !render) continue;
        
        if (render.node.position.y < cleanup.yMin) {
            if (!toRemove) toRemove = [NSMutableArray array];
            [toRemove addObject:entity];
        }
    }
    
    NSUInteger i, count = [toRemove count];
    for (i = 0; i < count; i++) {
        Entity *entity = toRemove[i];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        [render.node removeFromParentAndCleanup:YES];
        [m_EntManager removeEntityFromGame:entity];
    }
}

-(void)dealloc
{
    [super dealloc];
}

@end
