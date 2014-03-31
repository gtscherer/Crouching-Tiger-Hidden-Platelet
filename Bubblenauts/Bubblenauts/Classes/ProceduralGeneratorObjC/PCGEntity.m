//
//  PCGEntity.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGEntity.h"

@implementation PCGEntity

-(bool) isLessThan: (PCGEntity*) rhs
{
    if(self.symbol < rhs.symbol) return true;
    else return false;
}

-(bool) isLessThanOrEqualTo: (PCGEntity*) rhs
{
    if(self.symbol <= rhs.symbol) return true;
    else return false;
}

-(bool) isEqual: (PCGEntity*) rhs
{
    if(self.symbol == rhs.symbol) return true;
    else return false;
}

-(bool) isEntity:(char)rhs
{
    if(self.symbol == rhs) return true;
    else return false;
}

-(PCGEntity*) init
{
    if((self = [super init]))
    {
        
    }
    return self;
}

-(PCGEntity*) initWithSymbol:(char)symbol andFrequency:(NSInteger)frequency
{
    self = [super init];
    if(self)
    {
        [self setSymbol:symbol];
        [self setFrequency:frequency];
        [self setDimensions:[[PCGIntegerPair alloc] init]];
        [self setScaleFactors:[[NSMutableArray alloc] init]];
    }
    return self;
}

-(PCGEntity*) initWithSymbol:(char)symbol andFrequency:(NSInteger)frequency andDimensions:(PCGIntegerPair *)dimensions andScaleFactors:(NSArray*)scaleFactors
{
    self = [self initWithSymbol:symbol andFrequency:frequency];
    if(self)
    {
        [self setDimensions:dimensions];
        [self setScaleFactors:[[NSMutableArray alloc] initWithArray:scaleFactors]];
    }
    return self;
}

@end
