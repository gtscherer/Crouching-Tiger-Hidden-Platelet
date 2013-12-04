//
//  HelloWorldLayer.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/19/13.
//  Copyright Corvus 2013. All rights reserved.
//

#import "HelloWorldLayer.h"
#import "EntityManager.h"
#import "Entity.h"
#import "RenderSystem.h"
#import "GravitySystem.h"
#import "CleanupSystem.h"
#import "ForceSystem.h"
#import "EntityFactory.h"
#import "ScrollSystem.h"

#import "ForceComponent.h"

@interface HelloWorldLayer() {
//    NSArray *m_BGRefs;
    CGSize scrnSz;
    
    EntityManager *m_EntityManager;
    RenderSystem *m_RenderSys;
    GravitySystem *m_GravitySys;
    CleanupSystem *m_CleanupSys;
    ForceSystem *m_ForceSys;
    ScrollSystem *m_ScrollSys;
    EntityFactory *m_EntFactory;
}
@end

@implementation HelloWorldLayer

+ (CCScene *)scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
    
	return scene;
}

- (id)init
{
    self = [super init];
	if (self) {
		scrnSz = [[CCDirector sharedDirector] winSize];
        
//        CCSprite *background = [CCSprite spriteWithFile:@"Space.png"];
//        background.position = ccp(scrnSz.width/2, scrnSz.height/2);
//        [self addChild:background];
//        
//        CCSprite *background2 = [CCSprite spriteWithFile:@"Space.png"];
//        background2.position = ccp(scrnSz.width/2, scrnSz.height*1.5 - 1);
//        background2.flipY = TRUE;
//        [self addChild:background2];
        
//        m_BGRefs = [@[background, background2] retain];
        m_EntityManager = [[EntityManager alloc] init];
        m_EntFactory = [[EntityFactory alloc] initWithEntityManager:m_EntityManager nodeParent:self];
        m_GravitySys = [[GravitySystem alloc] initWithEntityManager:m_EntityManager];
        m_RenderSys = [[RenderSystem alloc] initWithEntityManager:m_EntityManager];
        m_CleanupSys = [[CleanupSystem alloc] initWithEntityManager:m_EntityManager];
        m_ForceSys = [[ForceSystem alloc] initWithEntityManager:m_EntityManager];
        m_ScrollSys = [[ScrollSystem alloc] initWithEntityManager:m_EntityManager];
        
        Entity *bg1 = [m_EntFactory scrollingBackgroundAtPoint:ccp(scrnSz.width/2, scrnSz.height/2)];
        Entity *bg2 = [m_EntFactory scrollingBackgroundAtPoint:ccp(scrnSz.width/2, scrnSz.height*1.5 - 1)];

        self.touchEnabled = TRUE;
        [self schedule:@selector(frameTick:) interval:1.0/30.0];
	}
	return self;
}

- (void)frameTick:(ccTime)dt
{
    // In one second, I want to move 20 pixels down...
//    for (CCSprite *bg in m_BGRefs) {
//        CGPoint pos = bg.position;
//        pos.y -= (dt * 20);
//        if (pos.y < (-scrnSz.height*0.5))
//            pos.y += (scrnSz.height*2 - 2);
//        bg.position = pos;
//    }
    
    [m_GravitySys update:dt];
    [m_RenderSys update:dt];
    [m_CleanupSys update:dt];
    [m_ForceSys update:dt];
    [m_ScrollSys update:dt];
}

- (void)addCreatureToWorldAtPoint:(CGPoint)point
{
    Entity *entity = [m_EntFactory createTestCreatureAtPoint:point];
    
    int lowerBound = -100;
    int upperBound = 100;
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    CGPoint aForce = ccp(rndValue, 0);
    ForceComponent *force = [[ForceComponent alloc] initWithForce:aForce];
    [m_EntityManager addComponent:force toEntity:entity];
    // could do something with the entity here
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint touchLoc = [self convertTouchToNodeSpace:aTouch];
    [self addCreatureToWorldAtPoint:touchLoc];
}

- (void)dealloc
{
//    [m_BGRefs release];
//    m_BGRefs = nil;
    
    [m_EntityManager release];
    m_EntityManager = nil;
    
    [m_EntFactory release];
    m_EntFactory = nil;
    
    [m_GravitySys release];
    m_GravitySys = nil;
    
    [m_RenderSys release];
    m_RenderSys = nil;
    
    [m_CleanupSys release];
    m_CleanupSys = nil;
    
    [m_ForceSys release];
    m_ForceSys = nil;
    
	[super dealloc];
}

@end
