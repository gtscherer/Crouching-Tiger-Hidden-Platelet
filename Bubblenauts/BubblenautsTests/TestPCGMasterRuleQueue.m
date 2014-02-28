//
//  TestPCGMasterRuleQueue.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/27/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCGMasterRuleQueue.h"
#import "PCGRule.h"

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

@interface TestPCGRuleList : XCTestCase

@property (nonatomic, strong) PCGRuleList* testRuleList;

@end

@implementation TestPCGRuleList

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    [self setTestRuleList: [[PCGRuleList alloc] init]];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [self setTestRuleList:nil];
    [super tearDown];
}

- (void) testAddRule
{
    PCGRule* testRule = mock([PCGRule class]);
    [given([testRule isEqual:testRule]) willReturnBool:YES];
    
    [[self testRuleList] addRule: testRule];
    
    XCTAssertEqual([[self testRuleList] count], (NSUInteger)1, @"Rule list should be 1 in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue([testRule isEqual:[[[[self testRuleList] rules] objectEnumerator] nextObject]], @"Test rule list should be equal in \"%s\"", __PRETTY_FUNCTION__);
}

@end
