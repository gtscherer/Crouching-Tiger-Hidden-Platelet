//
//  PCGPair.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGPair.h"

@implementation PCGIntegerPair

-(bool) equals: (PCGIntegerPair*) rhs
{
    if(self.first == rhs.first
       && self.second == rhs.second)
    {
        return YES;
    }
    else return NO;
}

@end

@implementation PCGDoublePair

-(bool) equals: (PCGDoublePair*) rhs
{
    if(self.first == rhs.first
       && self.second == rhs.second)
    {
        return YES;
    }
    else return NO;
}

@end

@implementation PCGPair

-(bool) equals: (PCGPair*) rhs
{
    if([self.first respondsToSelector:@selector(equals:)]
       && [self.second respondsToSelector:@selector(equals:)])
    {
        if([self.first equals:rhs.first]
           && [self.second equals:rhs.second])
        {
            return YES;
        }
        else return NO;
    }
    else return NO;
}


@end
