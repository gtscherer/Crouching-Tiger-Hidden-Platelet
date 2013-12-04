//
//  EntityFactory.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "EntityFactory.h"
#import "cocos2d.h"
#import "EntityManager.h"
#import "VelocityComponent.h"
#import "RenderComponent.h"
#import "GravityComponent.h"
#import "CleanupComponent.h"
#import "ScrollComponent.h"

@interface EntityFactory() {
    EntityManager *m_EntityManager;
    CCNode *m_ParentNode;
}

@end

@implementation EntityFactory

- (instancetype)initWithEntityManager:(EntityManager *)entityManager nodeParent:(CCNode *)parent
{
    self = [super init];
    if (self) {
        m_EntityManager = entityManager;
        m_ParentNode = parent;
    }
    return self;
}

- (Entity*)createTestCreatureAtPoint:(CGPoint)pt
{
    //create the components here...
    GravityComponent *grav = [[GravityComponent alloc] init];    //gravity
    VelocityComponent *vel = [[VelocityComponent alloc] init];   //velocity
    CleanupComponent *cleanup = [[CleanupComponent alloc] initWithMinY:-10.0f]; //cleanup
    
    //render
    CCSprite *sprite = [CCSprite spriteWithFile:@"enemy1.png"];
    sprite.position = pt;
    [m_ParentNode addChild:sprite];
    RenderComponent *render = [[RenderComponent alloc] initWithRenderNode:sprite];
    
    Entity *entity = [m_EntityManager createEntityWithComponents:@[grav, vel, cleanup, render]];
    
    [grav release];
    [vel release];
    [cleanup release];
    [render release];
    
    return entity;
}

- (Entity *)scrollingBackgroundAtPoint:(CGPoint)pt
{
    CGSize scrnSz = [[CCDirector sharedDirector] winSize];
    
    CCSprite *sprite = [CCSprite spriteWithFile:@"Space.png"];
    sprite.position = pt;
    [m_ParentNode addChild:sprite];
    RenderComponent *render = [[RenderComponent alloc] initWithRenderNode:sprite];
    
    ScrollComponent *scroll = [[ScrollComponent alloc] initWithYScrollSpeed:20.0f];
    scroll.shouldRepeat = YES;
    scroll.repeatPoint = -scrnSz.height*0.5;
    scroll.repeatOffset = scrnSz.height*2 - 2;
    
    Entity *entity = [m_EntityManager createEntityWithComponents:@[render, scroll]];
    
    [render release];
    [scroll release];
    
    return entity;
}

-(void)dealloc
{
    [super dealloc];
}

@end
