//
//  Pair.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCGIntegerPair : NSObject

@property (nonatomic) NSInteger first;
@property (nonatomic) NSInteger second;

-(bool) isEqual: (PCGIntegerPair*) rhs;

-(PCGIntegerPair*) initWithIntegers: (NSInteger) first secondInteger: (NSInteger) second;

@end


@interface PCGDoublePair : NSObject

@property (nonatomic) double first;
@property (nonatomic) double second;

-(bool) isEqual: (PCGDoublePair*) rhs;

-(PCGDoublePair*) initWithDoubles: (double) first secondDouble: (double) second;

@end


@interface PCGPair : NSObject

@property (nonatomic, strong) NSObject* first;
@property (nonatomic, strong) NSObject* second;

-(bool) isEqual: (PCGPair*) rhs;

-(PCGPair*) initWithObjects: (NSObject*) first secondObject: (NSObject*) second;

@end