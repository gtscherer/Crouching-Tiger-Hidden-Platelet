//
//  RenderComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "Component.h"
#import "cocos2d.h"

@interface RenderComponent : Component

@property (readonly) CCSprite *node;

- (instancetype)initWithRenderNode:(CCSprite*)node;

@end
