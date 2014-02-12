//
//  CleanupComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "CleanupComponent.h"

@implementation CleanupComponent

- (instancetype)initWithMinY:(float)y xThreshold:(CGPoint)xThresh
{
    self = [super init];
    if (self) {
        _yMin = y;
        _xThresh = xThresh;
        
        _causesGameOver = FALSE;
        _useXThreshold = TRUE;
        
        if (CGPointEqualToPoint(xThresh, CGPointZero))
            _useXThreshold = FALSE;
    }
    return self;
}

@end
