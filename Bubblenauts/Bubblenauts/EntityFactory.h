//
//  EntityFactory.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Entity;
@class EntityManager;

@interface EntityFactory : NSObject

- (instancetype)initWithEntityManager:(EntityManager*)entityManager;

- (Entity*)createTestCreature;

@end
