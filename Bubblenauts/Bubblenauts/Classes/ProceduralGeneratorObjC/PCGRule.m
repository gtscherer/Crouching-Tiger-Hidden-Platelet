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
    self = [super init];
    if(self)
    {
        [self setAreaAffected:areaAffected];
        [self setOffset:offset];
        [self setEntitySymbol: entitySymbol];
        [self setRuleType:ruleType];
    }
    return self;
}

@end
