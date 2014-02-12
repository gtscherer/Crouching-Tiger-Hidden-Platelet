//
//  HealthComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 1/29/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "Component.h"

@interface HealthComponent : Component

@property (assign) CGFloat health;

- (instancetype)initWithHealth:(CGFloat)health;

@end
