//
//  OptionsScene.m
//  buublenautsmenu
//
//  Created by kahayes3 on 1/28/14.
//  Copyright (c) 2014 kahayes3. All rights reserved.
//

#import "OptionsScene.h"
#import "IntroScene.h"
#import "ViewController.h"
#import "CreditsScene.h"
#import "InformationScene.h"
#import "HighScoreScene.h"
#import "AudioPlayer.h"

@interface OptionsScene ()
@property BOOL muted;
@property BOOL sceneCreated;
@end

@implementation OptionsScene

- (void) didMoveToView:(SKView *)view {
    
    if (!self.sceneCreated) {
        // Change the Backgroud color for welcome scene
        self.backgroundColor = [SKColor greenColor];
        
        // Fill the scene to entire view
        self.scaleMode = SKSceneScaleModeAspectFill;
        //[self addChild:[self changeUserNode]];
        [self addChild:[self createHSNode]];
        [self addChild:[self createCreditsNode]];
        [self addChild:[self createinformationNode]];
        [self addChild:[self createBackNode]];
        [self addChild:[self createHSText]];
        [self addChild:[self createInfoText]];
        [self addChild:[self createCreditsText]];
        [self addChild:[self createMuteNodeOff]];
        [self addChild:[self createMuteNodeOn]];
        
        self.sceneCreated = YES;
        self.muted = [[NSUserDefaults standardUserDefaults] boolForKey:@"MUTED"];
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
    SKNode *HSNode = [self childNodeWithName:@"HSNode"];
    SKNode *CreditsNode = [self childNodeWithName:@"CreditsNode"];
    SKNode *informationNode = [self childNodeWithName:@"informationNode"];
    SKNode *BackNode = [self childNodeWithName:@"BackNode"];
    SKNode *muteNodeOn = [self childNodeWithName:@"muteNodeOn"];
    SKNode *muteNodeOff = [self childNodeWithName:@"muteNodeOff"];
    
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];

        if ([HSNode containsPoint:location]) {
            // Scene Transition Animation
//            SKTransition* reveal = [SKTransition fadeWithDuration:0.5];
//            SKScene *hsScene = [[HighScoreScene alloc]initWithSize:self.size];
//            [self.scene.view presentScene:hsScene transition:reveal];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_SCOREBOARD" object:nil];
        }
        
        if ([CreditsNode containsPoint:location]) {
            // Scene Transition Animation
            SKTransition* reveal = [SKTransition fadeWithDuration:0.5];
            SKScene *creditsScene = [[CreditsScene alloc]initWithSize:self.size];
            [self.scene.view presentScene:creditsScene transition:reveal];
        }
        
        if ([informationNode containsPoint:location]) {
            // Scene Transition Animation
            SKTransition* reveal = [SKTransition fadeWithDuration:0.5];
            SKScene *informationScene = [[InformationScene alloc]initWithSize:self.size];
            [self.scene.view presentScene:informationScene transition:reveal];
        }
        
        if ([BackNode containsPoint:location]) {
            // Scene Transition Animation
            SKTransition* reveal = [SKTransition fadeWithDuration:0.5];
            SKScene *BackScene = [[IntroScene alloc]initWithSize:self.size];
            [self.scene.view presentScene:BackScene transition:reveal];
        }
        
        if([muteNodeOn containsPoint:location] || [muteNodeOff containsPoint:location]) {
            if (self.muted) {
                [[AudioPlayer sharedPlayer] startPlaying];
                muteNodeOn.hidden = NO;
                muteNodeOff.hidden = YES;
                self.muted = NO;
            }
            else {
                [[AudioPlayer sharedPlayer] stopPlaying];
                muteNodeOn.hidden = YES;
                muteNodeOff.hidden = NO;
                self.muted = YES;
            }
        }
    }
}


- (SKSpriteNode *)createHSNode {
    SKSpriteNode *HSNode = [SKSpriteNode spriteNodeWithImageNamed:@"HighScoreNode"];
    HSNode.name = @"HSNode";
    HSNode.position = CGPointMake(CGRectGetMidX(self.frame)-60, CGRectGetMidY(self.frame)+140);
    
    SKAction *action = [SKAction rotateByAngle:-M_PI duration:75];
    [HSNode runAction:[SKAction repeatActionForever:action]];
    return HSNode;
}

- (SKSpriteNode *)createHSText {
    SKSpriteNode *HSText = [SKSpriteNode spriteNodeWithImageNamed:@"HighScoreText"];
    HSText.name = @"HSNode";
    HSText.position = CGPointMake(CGRectGetMidX(self.frame)-60, CGRectGetMidY(self.frame)+55);
    return HSText;
}

- (SKSpriteNode *)createCreditsNode {
    SKSpriteNode *CreditsNode = [SKSpriteNode spriteNodeWithImageNamed:@"MonkeyInBubble"];
    CreditsNode.name = @"CreditsNode";
    CreditsNode.position = CGPointMake(CGRectGetMidX(self.frame)+80, CGRectGetMidY(self.frame)+20);
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:90];
    [CreditsNode runAction:[SKAction repeatActionForever:action]];
    return CreditsNode;
}

- (SKSpriteNode *)createCreditsText {
    SKSpriteNode *CreditsText = [SKSpriteNode spriteNodeWithImageNamed:@"CreditsText"];
    CreditsText.name = @"HSNode";
    CreditsText.position = CGPointMake(CGRectGetMidX(self.frame)+80, CGRectGetMidY(self.frame)-65);
    return CreditsText;
}

- (SKSpriteNode *)createinformationNode {
    SKSpriteNode *informationNode = [SKSpriteNode spriteNodeWithImageNamed:@"InfoNode"];
    informationNode.name = @"informationNode";
    informationNode.position = CGPointMake(CGRectGetMidX(self.frame)-20, CGRectGetMidY(self.frame)-140);
    
    SKAction *action = [SKAction rotateByAngle:M_PI duration:60];
    [informationNode runAction:[SKAction repeatActionForever:action]];
    return informationNode;
}

- (SKSpriteNode *)createInfoText {
    SKSpriteNode *InfoText = [SKSpriteNode spriteNodeWithImageNamed:@"InfoText"];
    InfoText.name = @"HSNode";
    InfoText.position = CGPointMake(CGRectGetMidX(self.frame)-20, CGRectGetMidY(self.frame)-225);
    return InfoText;
}

- (SKSpriteNode *)createBackNode {
    SKSpriteNode *BackNode = [SKSpriteNode spriteNodeWithImageNamed:@"BackNode"];
    BackNode.name = @"BackNode";
    BackNode.position = CGPointMake(CGRectGetMidX(self.frame)+110, CGRectGetMidY(self.frame)-200);
    return BackNode;
}

- (SKSpriteNode *) createMuteNodeOff {
    SKSpriteNode *muteNodeOff = [SKSpriteNode spriteNodeWithImageNamed:@"MuteNodeOff"];
    muteNodeOff.name = @"muteNodeOff";
    muteNodeOff.position = CGPointMake(CGRectGetMidX(self.frame)-120, CGRectGetMidY(self.frame)-200);
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"MUTED"]) {
        muteNodeOff.hidden = YES;
    }
    
    return muteNodeOff;
}

- (SKSpriteNode *) createMuteNodeOn {
    SKSpriteNode *muteNode = [SKSpriteNode spriteNodeWithImageNamed:@"MuteNodeOn"];
    muteNode.name = @"muteNodeOn";
    muteNode.position = CGPointMake(CGRectGetMidX(self.frame)-120, CGRectGetMidY(self.frame)-200);
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"MUTED"]) {
        muteNode.hidden = YES;
    }
    
    return muteNode;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
