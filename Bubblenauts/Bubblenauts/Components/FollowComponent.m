//
//  FollowComponent.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/27/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "FollowComponent.h"

@implementation FollowComponent

- (instancetype)initWithFollowNode:(Entity *)toFollow
{
    self = [super init];
    if (self) {
        _toFollow = toFollow;
    }
    return self;
}

@end
