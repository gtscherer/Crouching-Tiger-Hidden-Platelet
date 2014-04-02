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
       __block NSMutableArray* normalizedDistribution = [[NSMutableArray alloc] initWithArray:[self distribution]];
       double sum = [self getFrequencySum];
       double prevNum = 0;
       for(PCGPair* entityMapping in [self distribution])
       {
           double num = (double)([(NSNumber*)[entityMapping second] doubleValue] / sum);
           [entityMapping setSecond:[[NSNumber alloc] initWithDouble: num  + prevNum]];
           prevNum = num + prevNum;
       }
       NSArray *sortedDistribution = [normalizedDistribution sortedArrayUsingComparator: ^(PCGPair *a1, PCGPair *a2) {
           return [(NSNumber*) [a1 second] compare:(NSNumber*)[a2 second]];
       }];
       [self setNormalizedDistribution: sortedDistribution];
       return sortedDistribution;
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
