//
//  System.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "System.h"

@implementation System

- (instancetype)initWithEntityManager:(EntityManager *)entMan
{
    self = [super init];
    if (self) {
        _entManager = entMan;
    }
    return self;
}

- (void)update:(float)dt
{
    // Override in system subclasses!
}

- (void)dealloc
{
    [_entManager release];
    _entManager = nil;
    
    [super dealloc];
}

@end
