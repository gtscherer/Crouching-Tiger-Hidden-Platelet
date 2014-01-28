//
//  Entity.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/19/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "Entity.h"
#import "Component.h"

@interface Entity() {
    NSMutableDictionary *m_ComponentsByClass;
}
@end

@implementation Entity

+ (Entity*)entity
{
    return [[self alloc] init];
}

// Simple init method to initialize any variables
- (instancetype)init
{
    self = [super init];
    if (self) {
        m_ComponentsByClass = [NSMutableDictionary new];
    }
    return self;
}

// Return all components for this entity. We need to return an array
// of components, so we have to just extract all the values from
// the dictionary
- (NSArray*)allComponents
{
    return [m_ComponentsByClass allValues];
}

// Add a component into the store. Each entity tracks their own components
// in order to extract functionality away from the manager. So what we have
// to do is get a string from the component's class, and use it as a key
// into the dictionary. We then set the component as the objects for
// this key
- (void)addComponent:(Component*)component
{
    m_ComponentsByClass[NSStringFromClass([component class])] = component;
}

// Similar to the addComponent: method, but the exact opposite. We just
// get a string as the key using the component class, and then grab the
// object corresponding to that key (which is the component!)
- (Component*)getComponentOfClass:(Class)class
{
    return m_ComponentsByClass[NSStringFromClass(class)];
}

@end
