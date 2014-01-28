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

- (instancetype)initWithYScrollSpeed:(float)spd;

@end
