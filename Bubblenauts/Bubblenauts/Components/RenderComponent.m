//
//  RenderComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "RenderComponent.h"

@implementation RenderComponent

- (instancetype)initWithRenderNode:(CCSprite*)node
{
    self = [super init];
    if (self) {
        _node = node;
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end
