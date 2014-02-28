//
//  PCGMasterRuleQueue.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//
/*
 */
#import <Foundation/Foundation.h>
#import "PCGRule.h"

@interface PCGRuleList : NSObject

@property (nonatomic, strong) NSMutableSet* rules;
@property (nonatomic) bool hasExclusion;

-(NSSet*) getExclusions;

-(NSSet*) getForceGenerate;

-(bool) addRule: (PCGRule*) newRule;

-(NSUInteger) count;

@end


@interface PCGQueue : NSObject

@property (nonatomic, strong) NSMutableArray* queue;
@property (nonatomic, weak) id head;

-(void) enqueue: (id) object;

-(id) dequeue;

-(id) objectInQueueAtIndex:(NSInteger)index;

-(NSInteger) count;

@end


@interface PCGRevolver : NSObject

@property (nonatomic, strong) NSMutableArray* circuit;
@property (nonatomic, weak) id head;

-(void) addObject: (id) object;

-(id) popObjectAt: (NSInteger) index;

-(id) next;


-(NSInteger) count;

@end

@interface PCGRuleRevolver : PCGRevolver

-(void) createAndAddQueue;
-(id) objectInQueueAtIndex:(NSInteger) index inColumn: (NSInteger) column;
-(void) addObject: (PCGQueue*) queue;
-(void) addObject: (id) object toQueueAtIndex: (NSInteger) index;


@end