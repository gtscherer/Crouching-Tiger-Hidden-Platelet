//
//  EntityManager.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/19/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Entity;
@class Component;

@interface EntityManager : NSObject

- (Entity*)createEntityWithComponents:(NSArray*)comps;
- (NSArray*)getAllEntitiesWithComponentClass:(Class)aClass;

- (void)addComponent:(Component*)comp toEntity:(Entity*)entity;
- (void)removeComponent:(Component*)comp fromEntity:(Entity*)entity;

- (void)registerEntityToGame:(Entity*)entity;
- (void)removeEntityFromGame:(Entity*)entity;

@end
