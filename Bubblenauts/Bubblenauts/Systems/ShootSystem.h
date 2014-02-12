//
//  ShootSystem.h
//  Bubblenauts
//
//  Created by Breton Goers on 2/10/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "System.h"

@class EntityFactory;

@interface ShootSystem : System

@property (nonatomic, weak) EntityFactory *factory;

@end
