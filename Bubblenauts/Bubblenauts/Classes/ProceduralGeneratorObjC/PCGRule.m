//
//  LineGeneratorRule.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGRule.h"

@implementation PCGRule

-(bool) isEqual: (PCGRule*) rule
{
    if(self.entitySymbol == rule.entitySymbol
       && self.ruleType == rule.ruleType
       && [self.areaAffected isEqual:rule.areaAffected]
       && [self.offset isEqual:rule.offset])
        return YES;
    else return NO;
}

-(void) setAreaAffected:(PCGIntegerPair *)areaAffected
{
    self->_areaAffected = areaAffected;
    [self updateHash];
}

-(void) setEntitySymbol:(char)entitySymbol
{
    self->_entitySymbol = entitySymbol;
    [self updateHash];
}

-(void) setOffset:(PCGIntegerPair *)offset
{
    self->_offset = offset;
    [self updateHash];
}

-(void) setRuleType:(NSInteger)ruleType
{
    self->_ruleType = ruleType;
    [self updateHash];
}

-(void) updateHash
{
    NSUInteger output = (((((NSUInteger)[[self offset] first]) + ((NSUInteger) [[self offset] second])) % 1000) * 1000000) + (((((NSUInteger)[[self areaAffected] first]) + ((NSUInteger) [[self areaAffected] second])) % 1000) * 1000) + (((NSUInteger)[self entitySymbol] % 99) * 10) + ([self ruleType] % 2);
    
    [self setHashNumber: output];
}

-(NSUInteger) hash
{
    return [self hashNumber];
}

-(PCGRule*) init
{
    if((self = [super init]))
    {
        [self setOffset:[[PCGIntegerPair alloc] init]];
        [self setAreaAffected:[[PCGIntegerPair alloc] init]];
    }
    return self;
}


-(PCGRule*) initWithEntity:(char)entitySymbol andRuleType:(NSInteger)ruleType
{
    self = [super init];
    if(self)
    {
        [self setEntitySymbol: entitySymbol];
        [self setRuleType:ruleType];
    }
    return self;
}

-(PCGRule*) initWithEntity:(char)entitySymbol andRuleType:(NSInteger)ruleType andAreaAffected:(PCGIntegerPair *)areaAffected andOffset:(PCGIntegerPair *)offset
{
    self = [self initWithEntity:entitySymbol andRuleType:ruleType];
    if(self)
    {
        [self setAreaAffected:areaAffected];
        [self setOffset:offset];
    }
    return self;
}

@end
