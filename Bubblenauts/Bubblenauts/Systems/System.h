//
//  System.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntityManager;

@interface System : NSObject

@property (strong) EntityManager *entManager;

- (instancetype)initWithEntityManager:(EntityManager*)entMan;
- (void)update:(float)dt;

@end
