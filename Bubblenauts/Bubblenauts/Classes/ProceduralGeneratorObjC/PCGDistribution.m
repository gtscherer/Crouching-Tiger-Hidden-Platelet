//
//  PCGDistribution.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGDistribution.h"

@implementation PCGDistribution

-(PCGDistribution*) init
{
    if((self = [super init]))
    {
        [self setDistribution:[[NSMutableArray alloc] init]];
    }
    return self;
}

-(PCGDistribution*) initWithDistribution:(NSMutableArray *)distribution
{
    if((self = [super init]))
    {
        [self setDistribution:distribution];
    }
    return self;
}

-(double) getFrequencySum
{
    if([[self distribution] count] > 0)
    {
        double sum = 0;
        for(PCGPair* entityMapping in [self distribution])
        {
            sum += [(NSNumber*)[entityMapping second] doubleValue];
        }
        return sum;
    }
    else return 0;
}

-(NSUInteger) count
{
    return [[self distribution] count];
}

-(NSArray*) normalize
{
   if([self count] > 0)
   {
       NSMutableArray* normalizedDistribution = [[NSMutableArray alloc] initWithArray:[self distribution]];
       double sum = [self getFrequencySum];
       for(PCGPair* entityMapping in [self distribution])
       {
           [entityMapping setSecond:[[NSNumber alloc] initWithDouble: (double)([(NSNumber*)[entityMapping second] doubleValue] / sum)]];
       }
       [self setNormalizedDistribution: normalizedDistribution];
       return normalizedDistribution;
   }
   else
   {
       return nil;
   }

}

-(void) removeEntity: (PCGEntity*) entity
{
    [[self distribution] removeObject:[[PCGPair alloc] initWithObjects:entity secondObject:[[NSNumber alloc] initWithInteger:[entity frequency]]]];
}

-(void) addEntity: (PCGEntity*) entity
{
    [[self distribution] addObject:[[PCGPair alloc] initWithObjects:entity secondObject:[[NSNumber alloc] initWithInteger:[entity frequency]]]];
}


@end
