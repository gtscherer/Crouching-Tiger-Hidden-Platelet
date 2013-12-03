//
//  ForceComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "ForceComponent.h"

@implementation ForceComponent

- (instancetype)initWithForce:(CGPoint)force
{
    self = [super init];
    if (self) {
        _force = force;
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end
