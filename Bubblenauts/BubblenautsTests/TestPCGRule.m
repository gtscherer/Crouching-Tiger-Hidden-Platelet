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
#import "PCGPair.h"

@interface TestPCGRule : XCTestCase

@property (nonatomic, strong) PCGRule* testRule;

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
    [self setTestRule: nil];
    [super tearDown];
}

- (void)testInitWithEntityAndRuleType
{
    [self setTestRule:[[PCGRule alloc] initWithEntity:'t' andRuleType:FORCE]];
    
    XCTAssertTrue([[self testRule] entitySymbol] == 't', @"entitySymbol should be 't' in \"%s\"", __PRETTY_FUNCTION__ );
    
    XCTAssertTrue([[self testRule] ruleType] == FORCE, @"ruleType should be FORCE in \"%s\"", __PRETTY_FUNCTION__);
}

- (void) testInitWithEntityAndRuleTypeAndAreaAffectedAndOffset
{
    PCGIntegerPair* mockAreaAffected = mock([PCGIntegerPair class]);
    PCGIntegerPair* mockOffset = mock([PCGIntegerPair class]);
    
    NSInteger testAreaAffectedX = 5;
    NSInteger testAreaAffectedY = 9900000;
    
    NSInteger testOffsetX = -12414;
    NSInteger testOffsetY = 10139499;
    
    [given([mockAreaAffected first]) willReturnInt: testAreaAffectedX];
    [given([mockAreaAffected second]) willReturnInt: testAreaAffectedY];
    
    [given([mockOffset first]) willReturnInt:testOffsetX];
    [given([mockOffset second]) willReturnInt:testOffsetY];
    
    [self setTestRule: [[self testRule] initWithEntity:'z' andRuleType:EXCLUDE andAreaAffected:mockAreaAffected andOffset:mockOffset]];
    
    XCTAssertTrue([[self testRule] entitySymbol] == 'z', @"entitySymbol should be 'z' in \"%s\"", __PRETTY_FUNCTION__ );
    
    
    XCTAssertTrue([[self testRule] ruleType] == EXCLUDE, @"ruleType should be exclude in \"%s\"", __PRETTY_FUNCTION__ );
}

@end