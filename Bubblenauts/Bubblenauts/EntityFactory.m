//
//  EntityFactory.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "EntityFactory.h"
#import "cocos2d.h"
#import "EntityManager.h"

@interface EntityFactory() {
    EntityManager *m_EntityManager;
}

@end

@implementation EntityFactory

- (instancetype)initWithEntityManager:(EntityManager *)entityManager
{
    self = [super init];
    if (self) {
        m_EntityManager = [entityManager retain];
    }
    return self;
}

- (Entity*)createTestCreature
{
    
}

-(void)dealloc
{
    [m_EntityManager release];
    m_EntityManager = nil;
    
    [super dealloc];
}

@end
