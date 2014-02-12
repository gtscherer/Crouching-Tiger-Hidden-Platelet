//
//  CollisionSystem.h
//  Bubblenauts
//
//  Created by Breton Goers on 1/15/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "System.h"

@class Entity;

@interface CollisionSystem : System

// Always keep a ref to the hero to affect behavior on bubble collisions
@property (nonatomic, weak) Entity *heroRef;

// This will either be a bubble or the hero creature
@property (nonatomic, weak) Entity *toCheck;

@end
