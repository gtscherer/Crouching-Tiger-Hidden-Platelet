//
//  PCGPair.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGPair.h"

@implementation PCGIntegerPair

-(bool) isEqual: (PCGIntegerPair*) rhs
{
    if(self.first == rhs.first
       && self.second == rhs.second)
    {
        return YES;
    }
    else return NO;
}

-(PCGIntegerPair*) initWithIntegers:(NSInteger)first secondInteger:(NSInteger)second
{
    self = [super init];
    if(self)
    {
        [self setFirst: first];
        [self setSecond: second];
    }
    return self;
}

@end

@implementation PCGDoublePair

-(bool) isEqual: (PCGDoublePair*) rhs
{
    if(self.first == rhs.first
       && self.second == rhs.second)
    {
        return YES;
    }
    else return NO;
}

-(PCGDoublePair*) initWithDoubles:(double)first secondDouble:(double)second
{
    self = [super init];
    if(self)
    {
        [self setFirst: first];
        [self setSecond: second];
    }
    return self;
}

@end

@implementation PCGPair

-(bool) isEqual: (PCGPair*) rhs
{
    if([self.first isEqual:rhs.first]
        && [self.second isEqual:rhs.second])
    {
        return YES;
    }
    else return NO;
}

-(PCGPair*) initWithObjects:(NSObject *)first secondObject:(NSObject *)second
{
    self = [super init];
    if(self)
    {
        [self setFirst: first];
        [self setSecond: second];
    }
    return self;
}

@end
