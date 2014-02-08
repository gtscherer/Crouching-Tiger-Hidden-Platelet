//
//  PCGMasterRuleQueue.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCGRule.h"

@interface PCGRuleList : NSObject

@property (nonatomic, strong) NSMutableArray* rules;
@property (nonatomic) bool hasExclusion;

-(NSArray*) getExclusions;

-(NSArray*) getForceGenerate;

-(bool) addRule: (PCGRule*) newRule;

@end


@interface PCGQueue : NSObject

@property (nonatomic, strong) NSMutableArray* queue;
@property (nonatomic, weak) id head;

-(void) enqueue: (id) object;

-(id) dequeue;

-(id) objectInQueueAtIndex:(NSUInteger)index;

-(NSInteger) count;

@end


@interface PCGMasterRuleCircuit : NSObject

@property (nonatomic, strong) NSMutableArray* queue;
@property (nonatomic, weak) id head;

-(void) enqueue: (id) object atIndex: (int) index;

-(id) dequeue: (int) index;

-(bool) addQueue: (PCGQueue*) queue;

-(id) objectInQueueAtIndex:(NSUInteger) index inColumn: (NSUInteger) column;

-(int) count;

@end