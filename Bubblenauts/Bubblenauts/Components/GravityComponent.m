//
//  GravityComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "GravityComponent.h"

@implementation GravityComponent

-(instancetype)init
{
    self = [super init];
    if (self) {
        _gravity = CGPointMake(0.0f, -50.0f);
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end
