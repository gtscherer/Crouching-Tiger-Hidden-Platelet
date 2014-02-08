//
//  PCGMasterRuleQueue.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGMasterRuleQueue.h"

@implementation PCGRuleList

int const FORCE = 0;
int const EXCLUDE = 1;

-(NSArray*) getRuleByType: (int) type
{
    if([[self rules] count] > 0)
    {
        NSMutableArray* ruleList = [[NSMutableArray alloc] init];
        for(PCGRule* rule in [self rules])
        {
            if([rule ruleType] == type)
            {
                [ruleList addObject: rule];
            }
        }
        if([ruleList count] > 0) return ruleList;
        else return nil;
    }
    else return nil;
}

-(NSArray*) getExclusions
{
    return [self getRuleByType:EXCLUDE];
}

-(NSArray*) getForceGenerate
{
    return [self getRuleByType:FORCE];
}

-(bool) addRule: (PCGRule*) newRule
{
    for(PCGRule* rule in [self rules])
    {
        if([rule isEqual: newRule])
        {
            return false;
        }
    }
    [[self rules] addObject:newRule];
    return true;
}

@end

@implementation PCGQueue

-(PCGQueue*) initWithIndex: (NSUInteger) index
{
    self = (PCGQueue*) [super init];
    if(self)
    {
        [self setIndex:index];
    }
    return self;
}

-(void) enqueue: (id) object
{
    [[self queue] addObject:object];
    if([self count] == 1)
    {
        [[self head] setHead: object];
    }
}

-(id) dequeue
{
    id headObject = [[self queue] objectAtIndex:0];
    if(headObject)
    {
        [[self queue] removeObjectAtIndex:0];
        [self setHead:[[self queue] objectAtIndex:0]];
    }
    return headObject;

}

-(id) objectInQueueAtIndex:(NSUInteger)index
{
    if(index < [self count])
    {
        return [[self queue] objectAtIndex:index];
    }
    else return nil;
}

-(NSInteger) count
{
    return [[self queue] count];
}

@end


@implementation PCGMasterRuleCircuit

-(void) enqueue: (id) object atIndex: (int) index
{
    [(PCGQueue*)[[self queue] objectAtIndex:index]
     enqueue:object];
}

-(id) dequeue: (int) index
{
    if(index < [self count])
    {
        PCGQueue* headQueue = [[self queue] objectAtIndex:index];
        if(headQueue)
        {
            [[self queue] removeObjectAtIndex:index];
            [[self queue] addObject:headQueue];
            [[self head] setHead:[[self queue] objectAtIndex:0]];
        }
        return headQueue;
    }
    else return nil;
}

-(NSInteger) count
{
    return [[self queue] count];
}

-(void) addQueue: (PCGQueue*) queue
{
    [[self queue] addObject:queue];
}

-(void) createAndAddQueue
{
    PCGQueue* newQueue = [[PCGQueue alloc] initWithIndex:[self count]];
    [self addQueue: newQueue];
}

-(id) objectInQueueAtIndex:(NSUInteger) index inColumn: (NSUInteger) column
{
    if(column < [self count])
    {
        if(index < [(PCGQueue*) [[self queue] objectAtIndex: column] count])
        {
            return [(PCGQueue*) [[self queue] objectAtIndex:column] objectInQueueAtIndex:index];
        }
        else return nil;
    }
    else return nil;
}

@end
