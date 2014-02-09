//
//  TestPCGEntity.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 2/8/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

#import "PCGPair.h"
#import "PCGEntity.h"

@interface TestPCGEntity : XCTestCase

@property (nonatomic, strong) PCGEntity* testEntity;

@end

@implementation TestPCGEntity

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [self setTestEntity: nil];
    [super tearDown];
}

- (void)testInitWithSymbolAndFrequency
{
    char testSymbol = 'x';
    NSInteger testFrequency = 4;
    
    [self setTestEntity: [[PCGEntity alloc] initWithSymbol:testSymbol andFrequency:testFrequency]];
    
    XCTAssertTrue([[self testEntity] symbol] == testSymbol, @"Failed to insert entity symbol for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertTrue([[self testEntity] frequency] == testFrequency, @"Failed to insert frequency for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertNil([[self testEntity] dimensions], @"Dimensions should be nil for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertNil([[self testEntity] scaleFactors], @"ScaleFactors should be nil for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertNil([[self testEntity] exclusions], @"Exclusions should be nil for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertNil([[self testEntity] forceGeneration], @"forceGeneration should be nil for testEntity in \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testInitWithSymbolAndFrequencyAndDimensionsAndScaleFactors
{
    char testSymbol = 'x';
    NSInteger testFrequency = 4;
    
    PCGIntegerPair* testDimensions = mock([PCGIntegerPair class]);
    PCGDoublePair* testScaleFactors = mock([PCGDoublePair class]);
    NSInteger testInteger1 = 13123;
    NSInteger testInteger2 = -53242;
    double testDouble1 = 987.11;
    double testDouble2 = 0.0;
    
    //Create stubs
    [given([testDimensions first]) willReturnInt:testInteger1];
    [given([testDimensions second]) willReturnInt:testInteger2];
    [given([testScaleFactors first]) willReturnDouble:testDouble1];
    [given([testScaleFactors second]) willReturnDouble:testDouble2];
    
    [self setTestEntity: [[PCGEntity alloc] initWithSymbol:testSymbol andFrequency:testFrequency andDimensions:testDimensions andScaleFactors:testScaleFactors]];
    
    XCTAssertTrue([[self testEntity] symbol] == testSymbol, @"Failed to insert entity symbol for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue([[self testEntity] frequency] == testFrequency, @"Failed to insert frequency for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue((
                  [[[self testEntity] dimensions] first] == testInteger1
                  && [[[self testEntity] dimensions] second] == testInteger2),
                  @"Failed to insert frequency for testEntity in \"%s\"",
                  __PRETTY_FUNCTION__);
    
    XCTAssertTrue((
                   [[[self testEntity] scaleFactors] first] == testDouble1
                   && [[[self testEntity] scaleFactors] second] == testDouble2),
                  @"Failed to insert scaleFactors for testEntity in \"%s\"",
                  __PRETTY_FUNCTION__);
    
    XCTAssertNil([[self testEntity] exclusions], @"Exclusions should be nil for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertNil([[self testEntity] forceGeneration], @"forceGeneration should be nil for testEntity in \"%s\"", __PRETTY_FUNCTION__);
}
@end
