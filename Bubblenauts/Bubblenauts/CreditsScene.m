//
//  CreditsScene.m
//  buublenautsmenu
//
//  Created by Norman Hayes on 2/12/14.
//  Copyright (c) 2014 kahayes3. All rights reserved.
//

#import "CreditsScene.h"
#import "OptionsScene.h"
#import "IntroScene.h"
#import "ViewController.h"

@interface CreditsScene () {
    NSTimeInterval lastTime;
}
@property BOOL sceneCreated;

@end

@implementation CreditsScene

- (void) didMoveToView:(SKView *)view {
    if (!self.sceneCreated) {
        // Change the Backgroud color for welcome scene
        self.backgroundColor = [SKColor greenColor];
        
        // Fill the scene to entire view
        self.scaleMode = SKSceneScaleModeAspectFill;
        [self addChild: [self createBackNode]];
        [self addChild:[self textNode]];
        self.sceneCreated = YES;
    }
}

- (id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        _background = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
        [_background setName:@"background"];
        [_background setAnchorPoint:CGPointZero];
        [self addChild:_background];
        
        lastTime = 0;
    }
    
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    SKNode *BackNode = [self childNodeWithName:@"BackNode"];
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        if ([BackNode containsPoint:location]) {
            // Scene Transition Animation
            SKTransition* reveal = [SKTransition fadeWithDuration:0.5];
            SKScene *BackScene = [[OptionsScene alloc]initWithSize:self.size];
            [self.scene.view presentScene:BackScene transition:reveal];
        }
    }
}

- (SKSpriteNode *)createBackNode {
    SKSpriteNode *BackNode = [SKSpriteNode spriteNodeWithImageNamed:@"BackNode"];
    BackNode.name = @"BackNode";
    BackNode.position = CGPointMake(CGRectGetMidX(self.frame)+110, CGRectGetMidY(self.frame)-200);
    return BackNode;
}

- (SKNode *)textNode {
    SKNode *textNode = [SKNode node];
    textNode.name = @"textNode";
    
    SKLabelNode *a = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    a.fontSize = 20;
    a.fontColor = [SKColor yellowColor];
    SKLabelNode *b = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    b.fontSize = 16;
    b.fontColor = [SKColor yellowColor];
    SKLabelNode *c = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    c.fontSize = 16;
    c.fontColor = [SKColor yellowColor];
    SKLabelNode *d = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    d.fontSize = 16;
    d.fontColor = [SKColor yellowColor];
    SKLabelNode *e = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    e.fontSize = 16;
    e.fontColor = [SKColor yellowColor];
    SKLabelNode *f = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    f.fontSize = 16;
    f.fontColor = [SKColor yellowColor];
    SKLabelNode *g = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    g.fontSize = 16;
    g.fontColor = [SKColor yellowColor];
    SKLabelNode *h = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    h.fontSize = 20;
    h.fontColor = [SKColor yellowColor];
    SKLabelNode *i = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    i.fontSize = 16;
    i.fontColor = [SKColor yellowColor];
    SKLabelNode *j = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    j.fontSize = 20;
    j.fontColor = [SKColor yellowColor];
    SKLabelNode *k = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
    k.fontSize = 16;
    k.fontColor = [SKColor yellowColor];
    
    NSString *st1 = @"Created by:";
    NSString *st2 = @"Breton Goers";
    NSString *st3 = @"Alonso Durazo Leon";
    NSString *st4 = @"Jeff Morgan";
    NSString *st5 = @"Katie Hayes";
    NSString *st6 = @"Greggory Scherer";
    NSString *st7 = @"Allen Hsia";
    NSString *st8 = @"Music By:";
    NSString *st9 = @"Sergio TL";
    NSString *st10 = @"Special Thanks:";
    NSString *st11 = @"Elissa Thomas";
    
    b.position = CGPointMake(b.position.x, b.position.y - 20);
    c.position = CGPointMake(c.position.x, b.position.y - 20);
    d.position = CGPointMake(d.position.x, c.position.y - 20);
    e.position = CGPointMake(e.position.x, d.position.y - 20);
    f.position = CGPointMake(f.position.x, e.position.y - 20);
    g.position = CGPointMake(g.position.x, f.position.y - 20);
    h.position = CGPointMake(h.position.x, g.position.y - 50);
    i.position = CGPointMake(i.position.x, h.position.y - 20);
    j.position = CGPointMake(j.position.x, i.position.y - 50);
    k.position = CGPointMake(k.position.x, j.position.y - 20);
    
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
    k.text = st11;
    
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
    [textNode addChild:k];
    
    textNode.position = CGPointMake(CGRectGetMidX(self.frame), a.position.y);
    return textNode;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    /* Called about 1/60 of a second */
    CFTimeInterval dt = currentTime - lastTime;
    if (dt > 1) dt = 1.0 / 60.0;
    lastTime = currentTime;
    
    SKNode *textNode = [self childNodeWithName:@"textNode"];
    if (textNode.position.y >= (self.frame.size.height/2)+70) return;
    
    CGPoint pos = textNode.position;
    CGFloat perSec = (self.frame.size.height/2) / 10.0f;
    CGFloat stepChange = perSec*dt;
    pos.y += stepChange;
    textNode.position = pos;
}

@end
