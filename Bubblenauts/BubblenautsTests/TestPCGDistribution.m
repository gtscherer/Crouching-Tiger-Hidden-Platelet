//
//  TestPCGDistribution.m
//  Bubblenauts
//
//  Created by Greggory Scherer on 3/31/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PCGDistribution.h"
#import "PCGPair.h"
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>
@interface TestPCGDistribution : XCTestCase

@end

@implementation TestPCGDistribution

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

- (void) testInit
{
    PCGDistribution* testDistribution = [[PCGDistribution alloc] init];
    XCTAssertNotNil([testDistribution distribution], @"Array should not be nil in \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testInitWithDistribution
{
    NSMutableArray* mockArray = [[NSMutableArray alloc] init];
    [mockArray addObject:[[NSNumber alloc] initWithFloat:1.223f]];
    PCGDistribution* testDistribution = [[PCGDistribution alloc] initWithDistribution:mockArray];
    
    XCTAssertNotNil([testDistribution distribution], @"Array should not be nil in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertEqual([[[testDistribution distribution] objectAtIndex:0] floatValue], 1.223f, "Float should be stored in distribution in \"%s\"", __PRETTY_FUNCTION__);
    
}

-(void) testAddEntity
{
    PCGDistribution* testDistribution = [[PCGDistribution alloc] init];

    PCGEntity* mockEntity = mock([PCGEntity class]);
    [given([mockEntity symbol]) willReturnChar:'T'];
    [given([mockEntity frequency]) willReturnInteger: 0.0f];
    [testDistribution addEntity: mockEntity];
    
    XCTAssertTrue([[(PCGPair*)[[testDistribution distribution] objectAtIndex:0] first] isEqual:mockEntity], @"Mock entity should be in distribution in \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testRemoveEntity
{
    
    PCGEntity* mockEntity = mock([PCGEntity class]);
    [given([mockEntity symbol]) willReturnChar:'T'];
    [given([mockEntity frequency]) willReturnInteger: 0.0f];
    
    PCGDistribution* testDistribution = [[PCGDistribution alloc] initWithDistribution:[[NSMutableArray alloc] initWithObjects: [[PCGPair alloc] initWithObjects:mockEntity secondObject:[[NSNumber alloc] initWithFloat: [mockEntity frequency]]], nil]];
    
    [testDistribution removeEntity:mockEntity];
    
    XCTAssertEqual([[testDistribution distribution] count], (NSUInteger) 0, @"Object should have been removed from distribution in \"%s\"", __PRETTY_FUNCTION__);
    
}


-(void) testCount
{
    PCGEntity* mockEntity = mock([PCGEntity class]);
    [given([mockEntity symbol]) willReturnChar:'T'];
    [given([mockEntity frequency]) willReturnInteger: 0.0f];
    
    PCGDistribution* testDistribution = [[PCGDistribution alloc] initWithDistribution:[[NSMutableArray alloc] initWithObjects: [[PCGPair alloc] initWithObjects:mockEntity secondObject:[[NSNumber alloc] initWithFloat: [mockEntity frequency]]], nil]];
    
    XCTAssertEqual([testDistribution count], (NSUInteger) 1, @"Count should have been updated in distribution in \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testNormalize
{
    PCGEntity* mockEntity1 = mock([PCGEntity class]);
    PCGEntity* mockEntity2 = mock([PCGEntity class]);
    PCGEntity* mockEntity3 = mock([PCGEntity class]);

    [given([mockEntity1 symbol]) willReturnChar:'T'];
    [given([mockEntity2 symbol]) willReturnChar:'U'];
    [given([mockEntity3 symbol]) willReturnChar:'V'];
    
    [given([mockEntity1 frequency]) willReturnInteger:5];
    [given([mockEntity2 frequency]) willReturnInteger:6];
    [given([mockEntity3 frequency]) willReturnInteger:11];

    PCGDistribution* testDistribution = [[PCGDistribution alloc] init];
    
    [testDistribution addEntity: mockEntity1];
    [testDistribution addEntity: mockEntity2];
    [testDistribution addEntity: mockEntity3];
    
    [testDistribution normalize];
    
    // 5 + 6 + 11 = 22
    
    XCTAssertEqual((double)[(NSNumber*)[(PCGPair*)[[testDistribution normalizedDistribution] objectAtIndex:0] second] doubleValue] , (double) 0.22727272727273, @"Normalized distribution calculation error in \"%s\"", __PRETTY_FUNCTION__);
    
}

@end
