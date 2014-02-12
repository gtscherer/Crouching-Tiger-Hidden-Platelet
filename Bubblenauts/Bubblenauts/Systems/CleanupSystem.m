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

@import SpriteKit;

@interface CleanupSystem() {
    NSMutableArray *toRemove;
    Class cleanupClass;
    Class renderClass;
}
@end

@implementation CleanupSystem

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super initWithEntityManager:entMan];
    if (self) {
        toRemove = [NSMutableArray array];
        cleanupClass = [CleanupComponent class];
        renderClass = [RenderComponent class];
    }
    
    return self;
}

-(void)update:(float)dt
{
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
    
    for (Entity *entity in entities) {
        CleanupComponent *cleanup = (CleanupComponent*)[entity getComponentOfClass:cleanupClass];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (!cleanup || !render) continue;
        
        if (render.node.position.y < cleanup.yMin)
            [toRemove addObject:entity];
        
        if (cleanup.useXThreshold) {
            // x-coord here is the left-side x threshold (neg screen)
            if (render.node.position.x < cleanup.xThresh.x)
                [toRemove addObject:entity];
            
            // y-coord here is the right-side x threshold (pos past screen)
            if (render.node.position.x > cleanup.xThresh.y)
                [toRemove addObject:entity];
        }
    }
    
    BOOL shouldEndGame = FALSE;
    NSUInteger i, count = [toRemove count];
    for (i = 0; i < count; i++) {
        Entity *entity = toRemove[i];
        CleanupComponent *cleanup = (CleanupComponent*)[entity getComponentOfClass:cleanupClass];
        RenderComponent *render = (RenderComponent*)[entity getComponentOfClass:renderClass];
        
        if (cleanup.causesGameOver)
            shouldEndGame = TRUE;
        
        [render.node removeFromParent];
        [m_EntManager removeEntityFromGame:entity];
    }
    
    [toRemove removeAllObjects];
    if (shouldEndGame == TRUE) {
        // post the notification to end game!
        [[NSNotificationCenter defaultCenter] postNotificationName:GameOverCondition object:nil];
    }
}

@end
