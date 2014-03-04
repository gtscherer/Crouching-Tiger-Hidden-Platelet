//
//  PCGDistribution.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGPair.h"
#import "PCGEntity.h"
#import "PCGMasterRuleQueue.h"

@interface PCGDistribution : NSObject

@property (nonatomic, strong) NSMutableArray* distribution;
@property (nonatomic, strong) NSMutableArray* normalizedDistribution;

-(NSArray*) normalize;

-(void) removeEntity: (PCGEntity*) entity;

-(void) addEntity: (PCGEntity*) entity;

-(NSArray*) createDistributionFromExclusions: (PCGRuleList*) exclusions;

-(NSUInteger) count;

-(PCGDistribution*) initWithDistribution: (NSMutableArray*) distribution;

@end
