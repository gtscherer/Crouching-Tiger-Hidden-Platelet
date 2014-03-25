//
//  Entity.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/19/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Component;

@interface Entity : NSObject

/// Identifies the type of object this entity is
@property (nonatomic, assign) ObjectType type;

/// Returns all the components this entity has. The entity acts as a storage buffer
/// so that the EntityManager doesn't have to track it all.
@property (nonatomic, readonly) NSArray *allComponents;

+ (Entity*)entity;
- (void)addComponent:(Component*)component;
- (void)removeComponent:(Component*)component;
- (Component*)getComponentOfClass:(Class)class;

@end
