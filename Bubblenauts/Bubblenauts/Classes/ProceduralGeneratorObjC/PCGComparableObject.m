//
//  PCGComparableObject.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/7/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "PCGComparableObject.h"

@implementation PCGComparableObject

-(bool) equals: (PCGComparableObject*) rhs
{
    if([self equals: rhs]) return true;
    else return false;
}

@end
