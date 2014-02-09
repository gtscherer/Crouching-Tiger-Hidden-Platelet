//
//  PCGEntity.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGPair.h"
#import "PCGRule.h"

@interface PCGEntity : NSObject

@property (nonatomic, strong) NSMutableSet* exclusions;
@property (nonatomic, strong) NSMutableSet* forceGeneration;
@property (nonatomic, strong) PCGIntegerPair* dimensions;
@property (nonatomic, strong) PCGDoublePair* scaleFactors;
@property (nonatomic) NSInteger frequency;
@property (nonatomic) char symbol;

-(void) addExclusion: (PCGRule*) rule;

-(void) addForceGeneratedObject: (PCGRule*) rule;

-(bool) isLessThan: (PCGEntity*) rhs;

-(bool) isLessThanOrEqualTo: (PCGEntity*) rhs;

-(bool) isEqual: (PCGEntity*) rhs;

-(PCGEntity*) initWithSymbol: (char) symbol
                andFrequency: (NSInteger) frequency;

-(PCGEntity*) initWithSymbol: (char)symbol
                andFrequency: (NSInteger)frequency
               andDimensions: (PCGIntegerPair*) dimensions
             andScaleFactors: (PCGDoublePair*) scaleFactors;

-(PCGEntity*) initWithSymbol:(char)symbol
                andFrequency:(NSInteger)frequency
               andDimensions: (PCGIntegerPair*) dimensions
             andScaleFactors: (PCGDoublePair*) scaleFactors
               andExclusions: (NSMutableSet*) exclusions
          andForceGeneration: (NSMutableSet*) forceGeneration;


@end
