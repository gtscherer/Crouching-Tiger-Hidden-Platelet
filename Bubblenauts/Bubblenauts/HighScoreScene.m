//
//  HighScoreScene.m
//  buublenautsmenu
//
//  Created by Norman Hayes on 2/12/14.
//  Copyright (c) 2014 kahayes3. All rights reserved.
//

#import "HighScoreScene.h"

#import "CreditsScene.h"
#import "OptionsScene.h"
#import "IntroScene.h"
#import "ViewController.h"

@interface HighScoreScene ()

@property BOOL sceneCreated;

@end

@implementation HighScoreScene

- (void) didMoveToView:(SKView *)view {
    
    if (!self.sceneCreated) {
        // Change the Backgroud color for welcome scene
        self.backgroundColor = [SKColor greenColor];
        
        // Fill the scene to entire view
        self.scaleMode = SKSceneScaleModeAspectFill;
        //[self addChild:[self changeUserNode]];
        //[self addChild:[self createHSNode]];
        //[self addChild:[self createCreditsNode]];
        //[self addChild:[self createinformationNode]];
        [self addChild: [self createBackNode]];
        
        self.sceneCreated = YES;
    }
}

- (id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
        [_background setName:@"background"];
        [_background setAnchorPoint:CGPointZero];
        
        [self addChild:_background];
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    SKNode *BackNode = [self childNodeWithName:@"BackNode"];
    
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        
        if ([BackNode containsPoint:location]) {
            // Scene Transition Animation
            SKTransition* reveal = [SKTransition fadeWithDuration:0.5];
            SKScene *BackScene = [[OptionsScene alloc]initWithSize:self.size];
            [self.scene.view presentScene:BackScene transition:reveal];
        }
        
    }
}

- (SKSpriteNode *) createBackNode {
    
    SKSpriteNode *BackNode =
    [SKSpriteNode spriteNodeWithImageNamed:@"BackNode"];
//    [BackNode setScale:0.04];
    BackNode.name = @"BackNode";
    
    BackNode.position =
    CGPointMake(CGRectGetMidX(self.frame)+110, CGRectGetMidY(self.frame)-200);
    
    return BackNode;
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


@end
