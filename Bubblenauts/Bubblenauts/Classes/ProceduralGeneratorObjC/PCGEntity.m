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

-(PCGEntity*) initWithSymbol:(char)symbol andFrequency:(NSInteger)frequency
{
    self = [super init];
    if(self)
    {
        [self setSymbol:symbol];
        [self setFrequency:frequency];
    }
    return self;
}

-(PCGEntity*) initWithSymbol:(char)symbol andFrequency:(NSInteger)frequency andDimensions:(PCGIntegerPair *)dimensions andScaleFactors:(PCGDoublePair *)scaleFactors
{
    self = [self initWithSymbol:symbol andFrequency:frequency];
    if(self)
    {
        [self setDimensions:dimensions];
        [self setScaleFactors:scaleFactors];
    }
    return self;
}

-(PCGEntity*) initWithSymbol:(char)symbol andFrequency:(NSInteger)frequency andDimensions:(PCGIntegerPair *)dimensions andScaleFactors:(PCGDoublePair *)scaleFactors andExclusions:(NSMutableSet *)exclusions andForceGeneration:(NSMutableSet *)forceGeneration
{
    self = [self initWithSymbol:symbol
                   andFrequency:frequency
                  andDimensions:dimensions
                andScaleFactors:scaleFactors];
    if(self)
    {
        [self setExclusions:exclusions];
        [self setForceGeneration:forceGeneration];
    }
    return self;
    
}
@end
