//
//  LineGeneratorRule.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGPair.h"
#define FORCE 0
#define EXCLUDE 1


@interface PCGRule : NSObject

@property (nonatomic) char entitySymbol;
@property (nonatomic) NSInteger ruleType;

@property (nonatomic, strong) PCGIntegerPair* areaAffected;
@property (nonatomic, strong) PCGIntegerPair* offset;

-(bool) isEqual: (PCGRule*) rule;

-(PCGRule*) initWithEntity: (char) entitySymbol
               andRuleType: (NSInteger) ruleType;

-(PCGRule*) initWithEntity: (char) entitySymbol
               andRuleType: (NSInteger) ruleType
           andAreaAffected: (PCGIntegerPair*) areaAffected
                 andOffset: (PCGIntegerPair*) offset;


@end
