//
//  MyScene.m
//  buublenautsmenu
//
//  Created by kahayes3 on 1/28/14.
//  Copyright (c) 2014 kahayes3. All rights reserved.
//

#import "IntroScene.h"
#import "OptionsScene.h"
#import "MyScene.h"
#import "AudioPlayer.h"

@interface IntroScene()
@property BOOL sceneCreated;
@end

@implementation IntroScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.sceneCreated) {
        // Change the Backgroud color for welcome scene
        self.backgroundColor = [SKColor blueColor];
        
        // Fill the scene to entire view
        self.scaleMode = SKSceneScaleModeAspectFill;
        
        // Add a node to the scene
        [self addChild:[self createTitleNode]];
        [self addChild:[self createPlayNode]];
        [self addChild:[self createOptionsNode]];
        [self addChild:[self createMonkeyNode]];
        
        NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Bnmainmenu" withExtension:@"mp3"];
        AudioPlayer *player = [AudioPlayer sharedPlayer];
        [player loadBackgroundMusicAndPlay:backgroundMusicURL];
        
        self.sceneCreated = YES;
    }
}

- (id)initWithSize:(CGSize)size {
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
    
    SKNode *playNode = [self childNodeWithName:@"playNode"];
    SKNode *optionsNode = [self childNodeWithName:@"optionsNode"];
    
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        if ([playNode containsPoint:location]) {
            // Scene Transition Animation
            SKTransition *fade = [SKTransition fadeWithDuration:0.5];
            MyScene *myScene = [[MyScene alloc] initWithSize:self.size];
            [self.scene.view presentScene:myScene transition:fade];
        }
        if ([optionsNode containsPoint:location]) {
            // Scene Transition Animation
            SKTransition* reveal = [SKTransition fadeWithDuration:0.5];
            SKScene *optionsScene = [[OptionsScene alloc]initWithSize:self.size];
            [self.scene.view presentScene:optionsScene transition:reveal];
        }
    }
    
}

- (SKSpriteNode*)createTitleNode {
    SKSpriteNode *titleNode = [SKSpriteNode spriteNodeWithImageNamed:@"BubblenautsLogo"];
    titleNode.name = @"titleNode";
    titleNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    return titleNode; 
}

- (SKSpriteNode*)createMonkeyNode {
    SKSpriteNode *MonkeyNode = [SKSpriteNode spriteNodeWithImageNamed:@"Monkey"];
    MonkeyNode.name = @"MonkeyNode";
    MonkeyNode.position = CGPointMake(CGRectGetMidX(self.frame)+135, CGRectGetMidY(self.frame)+20);
    return MonkeyNode;
}


- (SKSpriteNode*)createPlayNode {
    SKSpriteNode *playNode = [SKSpriteNode spriteNodeWithImageNamed:@"PlayButton"];
    playNode.name = @"playNode";
    playNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+150);
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:30];
    [playNode runAction:[SKAction repeatActionForever:action]];
    return playNode;
}

- (SKSpriteNode*)createOptionsNode {
    SKSpriteNode *optionsNode = [SKSpriteNode spriteNodeWithImageNamed:@"OptionsButton"];
    optionsNode.name = @"optionsNode";
    optionsNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-150);
    
    SKAction *action = [SKAction rotateByAngle:-M_PI duration:23];
    [optionsNode runAction:[SKAction repeatActionForever:action]];
    return optionsNode;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
