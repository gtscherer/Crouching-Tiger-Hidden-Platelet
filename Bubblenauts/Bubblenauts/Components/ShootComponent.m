//
//  ShootComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 2/10/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "ShootComponent.h"

@implementation ShootComponent

- (instancetype)initWithFrequency:(CGFloat)freq
{
    self = [super init];
    if (self) {
        _frequency = freq;
    }
    return self;
}

@end
