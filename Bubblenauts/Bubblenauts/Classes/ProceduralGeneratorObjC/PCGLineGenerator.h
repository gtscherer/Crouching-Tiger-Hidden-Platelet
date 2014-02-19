//
//  PCGLineGenerator.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGDistribution.h"
#import "PCGMasterRuleQueue.h"

@interface PCGLineGenerator : NSObject

@property (nonatomic, strong) PCGDistribution* globalDistribution;
@property (nonatomic, strong) PCGRuleRevolver* masterRuleQueue;
@property (nonatomic) NSInteger width;

@end
