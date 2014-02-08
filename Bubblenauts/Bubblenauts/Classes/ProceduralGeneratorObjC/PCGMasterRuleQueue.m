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
        if([rule equals: newRule])
        {
            return false;
        }
    }
    [[self rules] addObject:newRule];
    return true;
}

@end

@implementation PCGQueue

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

-(int) count
{
    return [[self queue] count];
}

-(bool) addQueue: (PCGQueue*) queue;

-(id) objectInQueueAtIndex:(NSUInteger) index inColumn: (NSUInteger) column;

@end
