//
//  MovementComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 1/23/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "Component.h"

@interface FreeMoveComponent : Component

@property (assign) Direction direction;
@property (assign) BOOL goodToScroll;

@property (assign) CGPoint accelVec;
@property (assign) CGFloat stopY;

@end
