//
//  LineGeneratorRule.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGPair.h"

@interface PCGRule : NSObject

@property (nonatomic) char entity;
@property (nonatomic) NSInteger ruleType;

@property (nonatomic, strong) PCGIntegerPair* areaAffected;
@property (nonatomic, strong) PCGIntegerPair* offset;

-(bool) isEqual: (PCGRule*) rule;

@end
