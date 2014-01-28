//
//  CleanupComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "Component.h"

@interface CleanupComponent : Component

@property (assign, readonly) float yMin;
@property (assign) BOOL causesGameOver;

- (instancetype)initWithMinY:(float)y;

@end
