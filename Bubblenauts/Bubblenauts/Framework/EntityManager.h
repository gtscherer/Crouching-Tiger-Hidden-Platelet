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

- (Entity*)createNewBlankEntity;

- (void)addComponent:(Component*)comp toEntity:(Entity*)entity;
- (Component*)getComponentType:(Class)aClass onEntity:(Entity*)entity;

- (void)removeEntityFromGame:(Entity*)entity;
- (NSArray*)getAllEntitiesWithComponentClass:(Class)aClass;

@end
