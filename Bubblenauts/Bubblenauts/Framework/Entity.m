//
//  Entity.m
//  Bubblenauts
//
//  Created by Breton Goers on 11/19/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import "Entity.h"

@interface Entity() {
    uint32_t m_eID;
}
@end

@implementation Entity

- (id)initWithEntityID:(uint32_t)eID
{
    self = [super init];
    if (self) {
        m_eID = eID;
    }
    return self;
}

- (uint32_t)entityID
{
    return m_eID;
}

- (void)dealloc
{
    [super dealloc];
}

@end
