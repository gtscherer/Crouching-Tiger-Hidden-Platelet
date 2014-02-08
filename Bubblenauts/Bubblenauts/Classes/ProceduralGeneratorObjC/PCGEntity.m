//
//  PCGEntity.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGEntity.h"

@implementation PCGEntity

-(void) addExclusion: (PCGRule*) rule
{
    [[self exclusions] addObject: rule];
}

-(void) addForceGeneratedObject: (PCGRule*) rule
{
    [[self forceGeneration] addObject: rule];
}

-(bool) lessThan: (PCGEntity*) rhs
{
    if(self.symbol < rhs.symbol) return true;
    else return false;
}

-(bool) lessThanOrEqualTo: (PCGEntity*) rhs
{
    if(self.symbol <= rhs.symbol) return true;
    else return false;
}

-(bool) equals: (PCGEntity*) rhs
{
    if(self.symbol == rhs.symbol) return true;
    else return false;
}

@end
