//
//  PCGComparableObject.h
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCGComparableObject : NSObject

-(bool) equals: (PCGComparableObject*) rhs;

@end