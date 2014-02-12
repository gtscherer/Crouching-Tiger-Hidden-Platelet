//
//  HealthComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/29/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "HealthComponent.h"

@implementation HealthComponent

- (instancetype)initWithHealth:(CGFloat)health
{
    self = [super init];
    if (self) {
        _health = health;
    }
    return self;
}

@end
