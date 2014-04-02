//
//  PCGLineGenerator.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGDistribution.h"
#import "PCGEntity.h"

@interface PCGLineGenerator : NSObject

@property (nonatomic, strong) PCGEntity* blank;
@property (nonatomic, strong) PCGDistribution* globalDistribution;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger screenWidth;

-(NSInteger) getLineSize;

-(PCGEntity*) generateEntity;

-(NSArray*) generateLine;

@end
