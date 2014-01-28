//
//  FollowComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 1/27/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "Component.h"

@class Entity;

@interface FollowComponent : Component

@property (readonly) Entity *toFollow;

- (instancetype)initWithFollowNode:(Entity*)toFollow;

@end
