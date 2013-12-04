//
//  ScrollComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/3/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "ScrollComponent.h"

@implementation ScrollComponent

- (instancetype)initWithYScrollSpeed:(float)spd
{
    self = [super init];
    if (self) {
        _speed = spd;
        _shouldRepeat = NO;
        _repeatPoint = 0.0f;
        _repeatOffset = 0.0f;
    }
    return self;
}

@end
