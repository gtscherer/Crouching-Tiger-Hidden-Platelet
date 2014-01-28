//
//  RenderComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "Component.h"

@class SKSpriteNode;

@interface RenderComponent : Component

@property (readonly) SKSpriteNode *node;

- (instancetype)initWithRenderNode:(SKSpriteNode*)node;

@end
