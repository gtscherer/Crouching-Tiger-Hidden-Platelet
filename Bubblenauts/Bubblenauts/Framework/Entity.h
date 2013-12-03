//
//  Entity.h
//  Bubblenauts
//
//  Created by Breton Goers on 11/19/13.
//  Copyright (c) 2013 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Component;

@interface Entity : NSObject

@property (nonatomic, readonly) NSArray *allComponents;

+ (Entity*)entity;
- (void)addComponent:(Component*)component;
- (Component*)getComponentOfClass:(Class)class;

@end
