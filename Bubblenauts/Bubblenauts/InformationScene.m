//
//  InformationScene.m
//  buublenautsmenu
//
//  Created by Norman Hayes on 2/12/14.
//  Copyright (c) 2014 kahayes3. All rights reserved.
//

#import "InformationScene.h"

#import "CreditsScene.h"
#import "OptionsScene.h"
#import "IntroScene.h"
#import "ViewController.h"

@interface InformationScene ()

@property BOOL sceneCreated;

@end

@implementation InformationScene

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
        [self addChild: [self textNode]];
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
- (SKNode *)textNode
{
    SKNode *textNode = [SKNode node];
    textNode.name = @"helloNode";
    SKLabelNode *a = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    a.fontSize = 20;
    a.fontColor = [SKColor yellowColor];
    SKLabelNode *b = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    b.fontSize = 12;
    b.fontColor = [SKColor yellowColor];
    SKLabelNode *c = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    c.fontSize = 12;
    c.fontColor = [SKColor yellowColor];
    SKLabelNode *d = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    d.fontSize = 12;
    d.fontColor = [SKColor yellowColor];
    SKLabelNode *e = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    e.fontSize = 12;
    e.fontColor = [SKColor yellowColor];
    SKLabelNode *f = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    f.fontSize = 12;
    f.fontColor = [SKColor yellowColor];
    SKLabelNode *g = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    g.fontSize = 12;
    g.fontColor = [SKColor yellowColor];
    SKLabelNode *h = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    h.fontSize = 12;
    h.fontColor = [SKColor yellowColor];
    SKLabelNode *i = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    i.fontSize = 12;
    i.fontColor = [SKColor yellowColor];
    SKLabelNode *j = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    j.fontSize = 12;
    j.fontColor = [SKColor yellowColor];
    
    NSString *st1 = @"How to Play";
    NSString *st2 = @"With your finger, slide the monkey";
    NSString *st3 = @"left and right to avoid the flying objects.";
    NSString *st4 = @"";
    NSString *st5 = @"If you collide with a bubble,";
    NSString *st6 = @"your bubble will increase in size.";
    NSString *st7 = @"";
    NSString *st8 = @"If your bubble is too large,";
    NSString *st9 = @"it'll be harder to dodge objects!";
    NSString *st10 = @"Try to get the highest score!";
    
    b.position = CGPointMake(b.position.x, b.position.y - 20);
    c.position = CGPointMake(c.position.x, b.position.y - 20);
    d.position = CGPointMake(d.position.x, c.position.y - 20);
    e.position = CGPointMake(e.position.x, d.position.y - 20);
    f.position = CGPointMake(f.position.x, e.position.y - 20);
    g.position = CGPointMake(g.position.x, f.position.y - 20);
    h.position = CGPointMake(h.position.x, g.position.y - 20);
    i.position = CGPointMake(i.position.x, h.position.y - 20);
    j.position = CGPointMake(j.position.x, i.position.y - 20);
    a.text = st1;
    b.text = st2;
    c.text = st3;
    d.text = st4;
    e.text = st5;
    f.text = st6;
    g.text = st7;
    h.text = st8;
    i.text = st9;
    j.text = st10;
    
    [textNode addChild:a];
    [textNode addChild:b];
    [textNode addChild:c];
    [textNode addChild:d];
    [textNode addChild:e];
    [textNode addChild:f];
    [textNode addChild:g];
    [textNode addChild:h];
    [textNode addChild:i];
    [textNode addChild:j];
    
    textNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+100);
    
    
    return textNode;
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end