//
//  PCGLineGenerator.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//
#define ARC4RANDOM_MAX      0x100000000
#import "PCGLineGenerator.h"

@implementation PCGLineGenerator

-(id) init
{
    if((self = [super init]))
    {
        [self setWidth:136];
    }
    return self;
}

-(NSInteger) getLineSize
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    return screenWidth / [self width];
}

-(PCGEntity*) generateEntity
{
    double val = ((double)arc4random() / ARC4RANDOM_MAX);
    NSArray* normalizedDistribution = [[self globalDistribution] normalize];
    
    PCGEntity* entity;
    for(PCGPair* probabilityMapping in normalizedDistribution)
    {
        if(val < [(NSNumber*)[probabilityMapping second] doubleValue])
        {
            entity = (PCGEntity*) [probabilityMapping first];
        }
    }
    return entity;
}

-(NSArray*) generateLine
{
    NSMutableArray* line = [[NSMutableArray alloc] init];
    for(NSInteger i = 0; i < [self getLineSize]; ++i)
    {
        PCGEntity* entity = [self generateEntity];
        [line addObject:entity];
        if([entity symbol] == 'F')
        {
            for(NSInteger j = 0; j < [self getLineSize]; ++j)
            {
                if(j != i)
                {
                    [line setObject:[self blank] atIndexedSubscript:j];
                }
            }
        }
    }
    return line;
}

@end
