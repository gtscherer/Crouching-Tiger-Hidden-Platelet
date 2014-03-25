//
//  EntityManager.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/19/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "EntityManager.h"
#import "Entity.h"
#import "Component.h"

@interface EntityManager() {
    NSMutableDictionary *m_EntitiesByClass;
}
@end

@implementation EntityManager

- (id)init
{
    self = [super init];
    if (self) {
        m_EntitiesByClass = [NSMutableDictionary new];
    }
    return self;
}

// The m_EntitiesByClass dictionary contains arrays as objects, which contains
// entities. The key to access this array is a string created from the class
// of the component. So, a component type is mapped to all the entities that
// contains that component.
- (NSArray*)getAllEntitiesWithComponentClass:(Class)aClass
{
    NSArray *entities = m_EntitiesByClass[NSStringFromClass(aClass)];
    if (entities) {
        return entities;
    }
    
    return nil;
}

// Easy method to create a new entity. This allows us to just give components
// directly on instantiation, since entities now track their own components.
// Simply, we create an entity, add all the components, register it, and then
// return the entity.
- (Entity*)createEntityWithComponents:(NSArray *)comps
{
    Entity *entity = [Entity entity];
    for (Component *component in comps) {
        [entity addComponent:component];
    }
    
    [self registerEntityToGame:entity];
    
    return entity;
}

// In order to register this entity for use in the game, we need to make sure
// that the component type key has a reference to this entity to return. So we
// grab all components from the entity and iterate over them. In each iteration,
// we check if that component type has an associated array of entites. If not, we
// create it. Then we add a reference to this entity to that array.
- (void)registerEntityToGame:(Entity *)entity
{
    for (Component *component in [entity allComponents]) {
        NSMutableArray *entities = m_EntitiesByClass[NSStringFromClass([component class])];
        
        if (!entities) {
            entities = [NSMutableArray array];
            m_EntitiesByClass[NSStringFromClass([component class])] = entities;
        }
        
        [entities addObject:entity];
    }
}

// The opposite of the register method. We iterate all components on an entity, and
// if necessary remove the reference of that entity from the corresponding arrays.
- (void)removeEntityFromGame:(Entity *)entity
{
    for (Component *component in [entity allComponents]) {
        // Get the array of entities that have this component. THIS SHOULD EXIST.
        NSMutableArray *entities = m_EntitiesByClass[NSStringFromClass([component class])];
        [entity removeComponent:component];
        [entities removeObject:entity];
    }
}

//
-(void)addComponent:(Component *)comp toEntity:(Entity *)entity
{
    NSMutableArray *entities = m_EntitiesByClass[NSStringFromClass([comp class])];
    if (!entities) {
        entities = [NSMutableArray array];
        m_EntitiesByClass[NSStringFromClass([comp class])] = entities;
    }
    
    if ([entities containsObject:entity]) {
        NSLog(@"Tried to add a duplicate component.");
        [entities removeObject:entity];
    }
    
    [entity addComponent:comp];
    [entities addObject:entity];
}

//
-(void)removeComponent:(Component *)comp fromEntity:(Entity *)entity
{
    NSMutableArray *entities = m_EntitiesByClass[NSStringFromClass([comp class])];
    if (!entities) return;
    
    [entity removeComponent:comp];
    [entities removeObject:entity];
}

@end
