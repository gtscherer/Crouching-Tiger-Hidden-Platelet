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
    EnemyType,
    ForceType
};

typedef NS_ENUM(NSUInteger, Direction)
{
    DirectionUp,
    DirectionDown,
    DirectionLeft,
    DirectionRight
};

@interface Constants : NSObject

extern CGFloat const ConstGravity;
extern CGFloat const ConstFloatSpd;
extern CGFloat const MaxFallSpeed;
extern CGFloat const MaxFloatSpeed;
extern NSString * const GameOverCondition;
extern NSString * const BubblePoppedHealth;

@end
