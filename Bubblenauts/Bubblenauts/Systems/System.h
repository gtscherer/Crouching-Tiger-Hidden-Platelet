//
//  System.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/20/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EntityManager.h"
#import "Entity.h"

@interface System : NSObject {
    @protected
    EntityManager *m_EntManager;
}

@property (assign) BOOL active;

- (instancetype)initWithEntityManager:(EntityManager*)entMan;
- (void)update:(float)dt;

@end
