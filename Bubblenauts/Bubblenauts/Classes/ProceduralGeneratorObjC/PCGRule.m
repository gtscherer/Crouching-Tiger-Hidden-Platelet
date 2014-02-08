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
    if(self.entity == rule.entity
       && self.ruleType == rule.ruleType
       && [self.areaAffected isEqual:rule.areaAffected]
       && [self.offset isEqual:rule.offset])
        return YES;
    else return NO;
}

@end
