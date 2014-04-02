//
//  MyScene.h
//  Bubblenauts
//

//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PCGLineGenerator.h"
#import "PCGDistribution.h"
#import "PCGEntity.h"

@interface MyScene : SKScene

@property (strong, nonatomic) PCGLineGenerator* lineGenerator;
@property (strong, nonatomic) PCGDistribution* distribution;
@property (strong, nonatomic) PCGEntity* blank;
@property (strong, nonatomic) PCGEntity* bubble;
@property (strong, nonatomic) PCGEntity* asteroid;
@property (strong, nonatomic) PCGEntity* fan;


@end
