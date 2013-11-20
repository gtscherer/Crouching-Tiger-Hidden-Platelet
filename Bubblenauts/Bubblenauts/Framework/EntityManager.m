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
    NSMutableArray *m_Entities;
    NSMutableDictionary *m_Comps;
    uint32_t m_LowestEID;
}
@end

@implementation EntityManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        m_Entities = [NSMutableArray array];
        m_Comps = [NSMutableDictionary dictionary];
        m_LowestEID = 1;
    }
    return self;
}

- (uint32_t)generateNewEntityID
{
    if (m_LowestEID < UINT32_MAX) {
        return m_LowestEID++;
    }
    else {
        for (uint32_t i = 0; i < UINT32_MAX; ++i) {
            if (![m_Entities containsObject:@(i)]) {
                return i;
            }
        }
    }
    NSLog(@"Flagrant system error.");
    return 0;
}

- (Entity *)createNewBlankEntity
{
    uint32_t eID = [self generateNewEntityID];
    [m_Entities addObject:@(eID)];
    return [[Entity alloc] initWithEntityID:eID];
}

- (void)addComponent:(Component *)comp toEntity:(Entity *)entity
{
    NSString *compClass = NSStringFromClass([comp class]);
    
    NSMutableDictionary *components = m_Comps[compClass];
    if (!components) {
        components = [NSMutableDictionary dictionary];
        m_Comps[compClass] = components;
    }
    
    components[@([entity entityID])] = comp;
}

- (Component*)getComponentType:(Class)aClass onEntity:(Entity *)entity
{
    NSMutableDictionary *components = m_Comps[NSStringFromClass(aClass)];
    return components[@([entity entityID])];
}

- (void)removeEntityFromGame:(Entity *)entity
{
    // Entity ID in object form (it's Obj-C after all :) duh)
    NSNumber *eID = @([entity entityID]);
    
    // Iterate through all Component Types (don't know which our entity has)
    // If we find that a component type has this eID, we know the entity
    // contains that component. So we remove it!
    for (NSMutableDictionary *comps in [m_Comps allValues]) {
        if (comps[eID] != nil) {
            [comps removeObjectForKey:eID];
        }
    }
    
    // Finally, remove the entity ID, effectively eliminating it
    [m_Entities removeObject:eID];
}

- (NSArray*)getAllEntitiesWithComponentClass:(Class)aClass
{
    NSMutableDictionary *comps = m_Comps[NSStringFromClass(aClass)];
    if (comps != nil) {
        NSArray *allKeys = [comps allKeys];
        NSMutableArray *toRet = [NSMutableArray arrayWithCapacity:[allKeys count]];
        for (NSNumber *eID in allKeys) {
            [toRet addObject:[[Entity alloc] initWithEntityID:[eID integerValue]]];
        }
        return toRet;
    }
    else {
        return [NSArray array];
    }
}

@end
