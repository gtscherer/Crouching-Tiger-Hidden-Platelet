//
//  VelocityComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/27/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "VelocityComponent.h"

@implementation VelocityComponent

-(instancetype)init
{
    self = [super init];
    if (self) {
        _velocity = ccp(0.0f, 0.0f);
    }
    return self;
}

@end
