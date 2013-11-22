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

@interface HelloWorldLayer() {
    EntityManager *m_EntityManager;
}

@end

@implementation HelloWorldLayer

+(CCScene *)scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
    
	return scene;
}

-(id)init
{
    self = [super init];
	if (self) {
		CGSize size = [[CCDirector sharedDirector] winSize];
        CCSprite *background = [CCSprite spriteWithFile:@"Space.png"];
        background.position = ccp(size.width/2, size.height/2);
        [self addChild:background];

        self.touchEnabled = TRUE;
        m_EntityManager = [EntityManager new];
	}
	return self;
}

-(void)addCreatureToWorldAtPoint:(CGPoint)point
{
    
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint touchLoc = [self convertTouchToNodeSpace:aTouch];
    [self addCreatureToWorldAtPoint:touchLoc];
}

- (void)dealloc
{
	[super dealloc];
}

@end
