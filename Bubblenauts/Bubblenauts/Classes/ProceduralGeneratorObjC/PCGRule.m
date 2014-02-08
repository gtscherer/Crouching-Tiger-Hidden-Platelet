//
//  LineGeneratorRule.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGRule.h"

@implementation PCGRule

-(bool) equals: (PCGRule*) rule
{
    if(self.entity == rule.entity
       && self.ruleType == rule.ruleType
       && [self.areaAffected equals:rule.areaAffected]
       && [self.offset equals:rule.offset])
        return YES;
    else return NO;
}

@end
