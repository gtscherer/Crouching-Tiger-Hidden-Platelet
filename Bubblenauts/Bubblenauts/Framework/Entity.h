//
//  Entity.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/19/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entity : NSObject

- (id)initWithEntityID:(uint32_t)eID;
- (uint32_t)entityID;

@end
