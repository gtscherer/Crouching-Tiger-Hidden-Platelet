//
//  ForceComponent.h
//  Bubblenauts
//
//  Created by Breton Goers on 12/2/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "Component.h"

@interface ForceComponent : Component

@property (assign, readonly) CGPoint force;

- (instancetype)initWithForce:(CGPoint)force;

@end
