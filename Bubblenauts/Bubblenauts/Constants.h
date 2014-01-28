//
//  Constants.h
//  Bubblenauts
//
//  Created by Breton Goers on 1/15/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ObjectType)
{
    HeroType,
    BubbleType,
    SpikeType
};

@interface Constants : NSObject

extern CGFloat const ConstGravity;
extern CGFloat const ConstFloatSpd;
extern CGFloat const maxFallSpeed;
extern CGFloat const maxFloatSpeed;
extern NSString * const GameOverCondition;

@end
