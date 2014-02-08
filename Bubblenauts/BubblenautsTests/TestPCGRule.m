//
//  TestRule.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/6/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//
#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

#import "PCGRule.h"

@interface TestPCGRule : XCTestCase

@end

@implementation TestPCGRule

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testConstructor
{
    
}

@end
