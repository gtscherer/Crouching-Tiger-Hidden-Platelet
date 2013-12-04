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
@class CCNode;

@interface EntityFactory : NSObject

// Neither of these arguments are retained, so they must be retained elsewhere
// by your own class
- (instancetype)initWithEntityManager:(EntityManager*)entityManager nodeParent:(CCNode*)parent;
- (Entity*)createTestCreatureAtPoint:(CGPoint)pt;
- (Entity*)scrollingBackgroundAtPoint:(CGPoint)pt;

@end
