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
        m_EntManager = entMan;
    }
    return self;
}

- (void)update:(float)dt
{
    // Override in system subclasses!
}

- (void)dealloc
{
    [super dealloc];
}

@end
