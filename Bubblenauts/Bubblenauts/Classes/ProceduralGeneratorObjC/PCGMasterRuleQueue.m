//
//  PCGMasterRuleQueue.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGMasterRuleQueue.h"

@implementation PCGRuleList

-(NSSet*) getRulesByType: (int) type
{
    if([[self rules] count] > 0)
    {
        NSMutableSet* ruleList = [[NSMutableSet alloc] init];
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

-(NSSet*) getExclusions
{
    return [self getRulesByType:EXCLUDE];
}

-(NSSet*) getForceGenerate
{
    return [self getRulesByType:FORCE];
}

-(bool) addRule: (PCGRule*) newRule
{
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

-(id) objectInQueueAtIndex:(NSInteger)index
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


@implementation PCGRevolver

-(void) addObject:(id)object
{
    [[self circuit] addObject:object];
}

-(id) next
{
    return [self popObjectAt: 0];
}



-(id) popObjectAt: (NSInteger) index
{
    if(index > -1 && index < [self count])
    {
        PCGQueue* headQueue = [[self circuit] objectAtIndex:index];
        if(headQueue)
        {
            [[self circuit] removeObjectAtIndex:index];
            [[self circuit] addObject:headQueue];
            [[self head] setHead:[[self circuit] objectAtIndex:0]];
        }
        return headQueue;
    }
    else return nil;
}

-(NSInteger) count
{
    return [[self circuit] count];
}

@end

@implementation PCGRuleRevolver

-(void) addObject: (id) object toQueueAtIndex: (NSInteger) index
{
    [(PCGQueue*)[[self circuit] objectAtIndex:index]
     enqueue:object];
}

-(void) addObject:(PCGQueue *)queue
{
    [super addObject: queue];
}


-(id) objectInQueueAtIndex:(NSInteger) index inColumn: (NSInteger) column
{
    if(column < [self count])
    {
        if(index < [(PCGQueue*) [[self circuit] objectAtIndex: column] count])
        {
            return [(PCGQueue*) [[self circuit] objectAtIndex:column] objectInQueueAtIndex:index];
        }
        else return nil;
    }
    else return nil;
}

-(void) createAndAddQueue
{
    PCGQueue* newQueue = [[PCGQueue alloc] init];
    [self addObject: newQueue];
}

@end
