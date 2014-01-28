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
@class SKNode;

@interface EntityFactory : NSObject

- (instancetype)initWithEntityManager:(EntityManager*)entityManager nodeParent:(SKNode*)parent;
- (Entity*)createTestCreatureAtPoint:(CGPoint)pt;
//- (Entity*)scrollingBackgroundAtPoint:(CGPoint)pt;
- (Entity*)scrollingBubbleAtPoint:(CGPoint)pt;
- (Entity*)scrollingPlanetAtPoint:(CGPoint)pt;
- (Entity*)scrollingBlockAtPoint:(CGPoint)point;
- (Entity*)heroEntityAtPoint:(CGPoint)pt;

@end
