//
//  Pair.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGComparableObject.h"

@interface PCGIntegerPair : PCGComparableObject

@property (nonatomic) NSInteger first;
@property (nonatomic) NSInteger second;

-(bool) equals: (PCGIntegerPair*) rhs;

@end


@interface PCGDoublePair : PCGComparableObject

@property (nonatomic) double first;
@property (nonatomic) double second;

-(bool) equals: (PCGDoublePair*) rhs;

@end


@interface PCGPair : PCGComparableObject

@property (nonatomic, strong) PCGComparableObject* first;
@property (nonatomic, strong) PCGComparableObject* second;

-(bool) equals: (PCGPair*) rhs;

@end