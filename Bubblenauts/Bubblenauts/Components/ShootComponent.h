//
//  ShootComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 2/10/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "Component.h"

@interface ShootComponent : Component

@property (assign, readonly) CGFloat frequency;

- (instancetype)initWithFrequency:(CGFloat)freq;

@end
