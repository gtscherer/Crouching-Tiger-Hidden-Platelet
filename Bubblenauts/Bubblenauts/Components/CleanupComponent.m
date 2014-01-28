//
//  CleanupComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "CleanupComponent.h"

@implementation CleanupComponent

-(instancetype)initWithMinY:(float)y
{
    self = [super init];
    if (self) {
        _yMin = y;
        _causesGameOver = FALSE;
    }
    return self;
}

@end
