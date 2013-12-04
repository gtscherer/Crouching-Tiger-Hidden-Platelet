//
//  ScrollComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 12/3/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "Component.h"

@interface ScrollComponent : Component

@property (assign, readonly) float speed;

@property (assign) BOOL shouldRepeat;
@property (assign) float repeatPoint;
@property (assign) float repeatOffset;

- (instancetype)initWithYScrollSpeed:(float)spd;

@end
