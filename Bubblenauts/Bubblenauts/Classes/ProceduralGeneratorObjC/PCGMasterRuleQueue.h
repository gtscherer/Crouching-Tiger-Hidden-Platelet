//
//  PCGMasterRuleQueue.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//
/*
 
 "All those around you draw to a quiet. Your eyes dart across the room, but its just an illusion.
 The room doesn't exist, there's only you and I, and its almost like we cant fail at all,
 or maybe we've failed already. What you choose to see is real:
 a cold dark world of enemies, obstacles you could never overcome, or a bright future ahead.
 So tell the whole world and we'll start brand new. Strip the shackles off, let me look at you.
 If you can't reach out like youve been longing to, I'll have to rethink all that I thought I knew.
 Still you cant hear me call out your name and try to get through.
 I never hear back-never hear back. My words became a thousand arrows, slicing though the endless barricades,
 so that everyone on earth could hear my call, and I watched for you."
 
 "Procession of the Fates" - The Human Abstract
 
 */
#import <Foundation/Foundation.h>
#import "PCGRule.h"

@interface PCGRuleList : NSObject

@property (nonatomic, strong) NSMutableSet* rules;
@property (nonatomic) bool hasExclusion;

-(NSSet*) getExclusions;

-(NSSet*) getForceGenerate;

-(bool) addRule: (PCGRule*) newRule;

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