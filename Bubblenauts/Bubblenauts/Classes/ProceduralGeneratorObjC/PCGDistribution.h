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

@interface PCGDistribution : NSObject

@property (nonatomic, strong) NSMutableArray* distribution;

-(NSMutableArray*) getProbabilityList;

-(void) removeEntity: (PCGEntity*) entity;

@end
