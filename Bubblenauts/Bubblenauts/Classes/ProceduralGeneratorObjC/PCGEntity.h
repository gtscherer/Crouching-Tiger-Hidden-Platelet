//
//  PCGEntity.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGPair.h"

@interface PCGEntity : NSObject

@property (nonatomic, strong) PCGIntegerPair* dimensions;
@property (nonatomic, strong) NSMutableArray* scaleFactors;
@property (nonatomic) NSInteger frequency;
@property (nonatomic) char symbol;


-(bool) isLessThan: (PCGEntity*) rhs;

-(bool) isLessThanOrEqualTo: (PCGEntity*) rhs;

-(bool) isEqual: (PCGEntity*) rhs;

-(bool) isEntity: (char) rhs;

-(PCGEntity*) initWithSymbol: (char) symbol
                andFrequency: (NSInteger) frequency;

-(PCGEntity*) initWithSymbol: (char)symbol
                andFrequency: (NSInteger)frequency
               andDimensions: (PCGIntegerPair*) dimensions
             andScaleFactors: (NSArray*) scaleFactors;



@end
