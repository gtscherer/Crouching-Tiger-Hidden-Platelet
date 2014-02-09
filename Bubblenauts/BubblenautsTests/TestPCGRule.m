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
    
    [self setTestRule: [[PCGRule alloc] initWithEntity:'z' andRuleType:EXCLUDE andAreaAffected:mockAreaAffected andOffset:mockOffset]];
    
    XCTAssertTrue([[self testRule] entitySymbol] == 'z', @"entitySymbol should be 'z' in \"%s\"", __PRETTY_FUNCTION__ );
    
    
    XCTAssertTrue([[self testRule] ruleType] == EXCLUDE, @"ruleType should be exclude in \"%s\"", __PRETTY_FUNCTION__ );
    
    XCTAssertEqual([[self testRule] areaAffected], mockAreaAffected, @"Failed to set areaAffected in \"%s\"", __PRETTY_FUNCTION__ );
    
    XCTAssertEqual([[self testRule] offset], mockOffset, @"Failed to set offset in \"%s\"", __PRETTY_FUNCTION__);
    
}

- (void) testIsEqual
{
    
    //Create mock objects
    PCGRule* mockRule = mock([PCGRule class]);
    PCGIntegerPair* mockAreaAffected = mock([PCGIntegerPair class]);
    PCGIntegerPair* mockOffset = mock([PCGIntegerPair class]);
    
    char testEntitySybmol = 'c';
    NSInteger testRuleType = FORCE;
    
    NSInteger testAreaAffectedX = 2112;
    NSInteger testAreaAffectedY = -5000;
    
    NSInteger testOffsetX = -12414;
    NSInteger testOffsetY = -10139499;
    
    //Create Stubs
    [given([mockAreaAffected first]) willReturnInt: testAreaAffectedX];
    [given([mockAreaAffected second]) willReturnInt: testAreaAffectedY];
    
    [given([mockOffset first]) willReturnInt:testOffsetX];
    [given([mockOffset second]) willReturnInt:testOffsetY];
    
    [given([mockRule areaAffected]) willReturn: mockAreaAffected];
    [given([mockRule offset]) willReturn: mockOffset];
    [given([mockRule entitySymbol]) willReturnChar:testEntitySybmol];
    [given([mockRule ruleType]) willReturnInt: testRuleType];
    
    //Create test object with parameters
    [self setTestRule: [[PCGRule alloc] initWithEntity:testEntitySybmol andRuleType:testRuleType andAreaAffected:mockAreaAffected andOffset:mockOffset]];
    
    //Assert that test object and mocked object are equal
    XCTAssertTrue([[self testRule] isEqual:mockRule], @"Test object does not equal mock object in \"%s\"", __PRETTY_FUNCTION__);
    
}

- (void) testIntegratedWithPCGPair
{
    char testEntitySymbol = 'a';
    NSInteger testRuleType = EXCLUDE;
    
    NSInteger testAreaAffectedX = (5/4);
    NSInteger testAreaAffectedY = 50500;
    
    NSInteger testOffsetX = 12414;
    NSInteger testOffsetY = 10139499;
    
    PCGIntegerPair* testAreaAffected = [[PCGIntegerPair alloc] initWithIntegers:testAreaAffectedX secondInteger:testAreaAffectedY];
    PCGIntegerPair* testOffset = [[PCGIntegerPair alloc] initWithIntegers:testOffsetX secondInteger:testOffsetY];
    
    [self setTestRule:[[PCGRule alloc] initWithEntity:testEntitySymbol andRuleType:testRuleType andAreaAffected:testAreaAffected andOffset:testOffset]];
    
    PCGRule* newRule = [[PCGRule alloc] initWithEntity:testEntitySymbol andRuleType:testRuleType andAreaAffected:testAreaAffected andOffset:testOffset];
    
    XCTAssertTrue([[self testRule] isEqual:newRule], @"Test object does not equal other test object in \"%s\"", __PRETTY_FUNCTION__);
}


@end
