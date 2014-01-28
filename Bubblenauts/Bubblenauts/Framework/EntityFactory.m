//
//  EntityFactory.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "Entity.h"
#import "EntityFactory.h"
#import "EntityManager.h"
#import "VelocityComponent.h"
#import "RenderComponent.h"
#import "CleanupComponent.h"
#import "ScrollComponent.h"
#import "MoveComponent.h"
#import "CollisionComponent.h"

@import SpriteKit;

@interface EntityFactory() {
    EntityManager *m_EntityManager;
    SKNode *m_ParentNode;
}

@end

@implementation EntityFactory

- (instancetype)initWithEntityManager:(EntityManager *)entityManager nodeParent:(SKNode *)parent
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
    CGSize scrnSz = [[UIScreen mainScreen] bounds].size;
    
    //create the components here...
    VelocityComponent *vel = [[VelocityComponent alloc] init];   //velocity
    CleanupComponent *cleanup = [[CleanupComponent alloc] initWithMinY:-10.0f]; //cleanup
    CollisionComponent *coll = [[CollisionComponent alloc] init];
    
    //render
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Enemy1"];
    sprite.position = pt;
    [m_ParentNode addChild:sprite];
    RenderComponent *render = [[RenderComponent alloc] initWithRenderNode:sprite];
    
    MoveComponent *move = [[MoveComponent alloc] init];
    move.accelVec = ccp(0.0f, ConstGravity);
    move.stopY = scrnSz.height*0.5;
    move.direction = DirectionDown;
    move.goodToScroll = FALSE;
    
    Entity *entity = [m_EntityManager createEntityWithComponents:@[/*grav*/move, vel, cleanup, render, coll]];
    entity.type = HeroType;
    return entity;
}

//- (Entity *)scrollingBackgroundAtPoint:(CGPoint)pt
//{
//    CGSize scrnSz = [[UIScreen mainScreen] bounds].size;
//    
//    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
//    sprite.position = pt;
//    [m_ParentNode addChild:sprite];
//    
//    RenderComponent *render = [[RenderComponent alloc] initWithRenderNode:sprite];
//    ScrollComponent *scroll = [[ScrollComponent alloc] initWithYScrollSpeed:10.0f];
//    scroll.shouldRepeat = YES;
//    scroll.repeatPoint = -scrnSz.height*0.5;
//    scroll.repeatOffset = scrnSz.height*2 - 2;
//    
//    Entity *entity = [m_EntityManager createEntityWithComponents:@[render, scroll]];
//    return entity;
//}

- (Entity *)scrollingPlanetAtPoint:(CGPoint)pt
{
    NSString *planetName;
    if (arc4random() % 2) planetName = @"RedPlanet";
    else planetName = @"MoonPlanet";
    
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:planetName];
    sprite.position = pt;
    [m_ParentNode addChild:sprite];
    
    RenderComponent *render = [[RenderComponent alloc] initWithRenderNode:sprite];
    CleanupComponent *cleanup = [[CleanupComponent alloc] initWithMinY:-40.0f];
    ScrollComponent *scroll = [[ScrollComponent alloc] initWithYScrollSpeed:maxFloatSpeed];
//    scroll.shouldRepeat = NO;
    
    Entity *entity = [m_EntityManager createEntityWithComponents:@[render, scroll, cleanup]];
    return entity;
}

- (Entity*)scrollingBubbleAtPoint:(CGPoint)pt
{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Bubble"];
    sprite.position = pt;
    [m_ParentNode addChild:sprite];
    
    RenderComponent *render = [[RenderComponent alloc] initWithRenderNode:sprite];
    CleanupComponent *cleanup = [[CleanupComponent alloc] initWithMinY:-40.0f];
    ScrollComponent *scroll = [[ScrollComponent alloc] initWithYScrollSpeed:maxFloatSpeed];
    CollisionComponent *coll = [[CollisionComponent alloc] init];
    //    scroll.shouldRepeat = NO;
    
    Entity *entity = [m_EntityManager createEntityWithComponents:@[render, scroll, cleanup, coll]];
    entity.type = BubbleType;
    return entity;
}

- (Entity *)scrollingBlockAtPoint:(CGPoint)point
{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Block"];
    sprite.position = point;
    [m_ParentNode addChild:sprite];
    
    RenderComponent *render = [[RenderComponent alloc] initWithRenderNode:sprite];
    CleanupComponent *cleanup = [[CleanupComponent alloc] initWithMinY:-10.0f];
    ScrollComponent *scroll = [[ScrollComponent alloc] initWithYScrollSpeed:60.0f];
//    scroll.shouldRepeat = NO;
    
    Entity *entity = [m_EntityManager createEntityWithComponents:@[render, scroll, cleanup]];
    return entity;
}

// Hero must be rendered (render comp)
// Hero must collide (collision comp)
// Hero must have cleanup component (causes game over)
// 
- (Entity *)heroEntityAtPoint:(CGPoint)pt
{
    SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Enemy2"];
    sprite.position = pt;
    [m_ParentNode addChild:sprite];
    
//    RenderComponent *render = [[RenderComponent alloc] initWithRenderNode:sprite];
    
    return nil;
}

@end
