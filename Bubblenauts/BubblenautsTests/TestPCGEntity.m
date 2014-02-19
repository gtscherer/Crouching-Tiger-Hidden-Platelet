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

@interface TestPCGEntityConstructors : XCTestCase

@property (nonatomic, strong) PCGEntity* testEntity;

@end

@implementation TestPCGEntityConstructors

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
    NSMutableArray* testScaleFactors = [[NSMutableArray alloc] init];
    PCGPair* testScaleFactorTypeMap = mock([PCGPair class]);
    PCGDoublePair* testScaleFactor = mock([PCGDoublePair class]);
    
    
    NSInteger testInteger1 = 13123;
    NSInteger testInteger2 = -53242;
    NSNumber* testInteger3 = [[NSNumber alloc] initWithInt: 234];
    double testDouble1 = 987.11;
    double testDouble2 = 0.0;
    
    [testScaleFactors addObject:testScaleFactorTypeMap];

    //Create stubs
    [given([testScaleFactor first]) willReturnDouble:testDouble1];
    [given([testScaleFactor second]) willReturnDouble:testDouble2];
    [given([testScaleFactorTypeMap first]) willReturn:testScaleFactor];
    [given([testScaleFactorTypeMap second]) willReturn: testInteger3];
    [given([testDimensions first]) willReturnInt:testInteger1];
    [given([testDimensions second]) willReturnInt:testInteger2];
    [given([testScaleFactors objectAtIndex:0]) willReturn:testScaleFactorTypeMap];
    
    
    [self setTestEntity: [[PCGEntity alloc] initWithSymbol:testSymbol andFrequency:testFrequency andDimensions:testDimensions andScaleFactors:testScaleFactors]];
    
    XCTAssertTrue([[self testEntity] symbol] == testSymbol, @"Failed to insert entity symbol for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue([[self testEntity] frequency] == testFrequency, @"Failed to insert frequency for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue((
                  [[[self testEntity] dimensions] first] == testInteger1
                  && [[[self testEntity] dimensions] second] == testInteger2),
                  @"Failed to insert frequency for testEntity in \"%s\"",
                  __PRETTY_FUNCTION__);
    
    XCTAssertTrue((
                   [(PCGDoublePair*)[(PCGPair*)[[[self testEntity] scaleFactors] objectAtIndex:0] first] first]== testDouble1),@"Failed to insert scaleFactors for testEntity in \"%s\"",
                   __PRETTY_FUNCTION__);
    
    XCTAssertTrue(([(PCGDoublePair*)[(PCGPair*)[[[self testEntity] scaleFactors] objectAtIndex:0] first] second] == testDouble2),@"Failed to insert scaleFactors for testEntity in \"%s\"",
                  __PRETTY_FUNCTION__);
    
    XCTAssertTrue(([(NSNumber*)[(PCGPair*)[[[self testEntity] scaleFactors] objectAtIndex:0] second] isEqual:testInteger3]), @"Failed to insert scaleFactors for testEntity in \"%s\"",__PRETTY_FUNCTION__);
    
    
    XCTAssertNil([[self testEntity] exclusions], @"Exclusions should be nil for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertNil([[self testEntity] forceGeneration], @"forceGeneration should be nil for testEntity in \"%s\"", __PRETTY_FUNCTION__);
}


-(void) testInitWithSymbolFrequencyDimensionScalefactorsExclusionsAndFG
{
    char testSymbol = '#';
    NSInteger testFrequency = 1;
    
    PCGIntegerPair* testDimensions = mock([PCGIntegerPair class]);
    NSMutableArray* testScaleFactors = [[NSMutableArray alloc] init];
    PCGPair* testScaleFactorTypeMap = mock([PCGPair class]);
    PCGDoublePair* testScaleFactor = mock([PCGDoublePair class]);
    NSInteger testInteger1 = 23;
    NSInteger testInteger2 = 44*(-1);
    NSNumber* testInteger3 = [[NSNumber alloc] initWithInt: -234];
    double testDouble1 = 0.11;
    double testDouble2 = 100.0;
    NSMutableSet* testSet1 = [[NSMutableSet alloc] init];
    NSMutableSet* testSet2 = [[NSMutableSet alloc] init];

    [testSet1 addObject:[[NSNumber alloc] initWithInteger:testInteger1]];
    [testSet1 addObject:[[NSNumber alloc] initWithInteger:testInteger2]];
    
    [testSet2 addObject:[[NSNumber alloc] initWithDouble:testDouble1]];
    [testSet2 addObject:[[NSNumber alloc] initWithDouble:testDouble2]];
    
    [testScaleFactors addObject:testScaleFactorTypeMap];

    
    //Create stubs
    [given([testScaleFactor first]) willReturnDouble:testDouble1];
    [given([testScaleFactor second]) willReturnDouble:testDouble2];
    [given([testScaleFactorTypeMap first]) willReturn:testScaleFactor];
    [given([testScaleFactorTypeMap second]) willReturn: testInteger3];
    [given([testDimensions first]) willReturnInt:testInteger1];
    [given([testDimensions second]) willReturnInt:testInteger2];
    [given([testScaleFactors objectAtIndex:0]) willReturn:testScaleFactorTypeMap];
    
    [self
     setTestEntity:
     [[PCGEntity alloc] initWithSymbol:testSymbol
                          andFrequency:testFrequency
                         andDimensions:testDimensions
                       andScaleFactors:testScaleFactors
                         andExclusions:testSet1
                    andForceGeneration:testSet2]];
    
    XCTAssertTrue([[self testEntity] symbol] == testSymbol, @"Failed to insert entity symbol for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue([[self testEntity] frequency] == testFrequency, @"Failed to insert frequency for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue((
                   [[[self testEntity] dimensions] first] == testInteger1
                   && [[[self testEntity] dimensions] second] == testInteger2),
                  @"Failed to insert frequency for testEntity in \"%s\"",
                  __PRETTY_FUNCTION__);
    
    
    XCTAssertTrue((
                   [(PCGDoublePair*)[(PCGPair*)[[[self testEntity] scaleFactors] objectAtIndex:0] first] first]== testDouble1),@"Failed to insert scaleFactors for testEntity in \"%s\"",
                  __PRETTY_FUNCTION__);
    
    XCTAssertTrue(([(PCGDoublePair*)[(PCGPair*)[[[self testEntity] scaleFactors] objectAtIndex:0] first] second] == testDouble2),@"Failed to insert scaleFactors for testEntity in \"%s\"",
                  __PRETTY_FUNCTION__);
    
    XCTAssertTrue(([(NSNumber*)[(PCGPair*)[[[self testEntity] scaleFactors] objectAtIndex:0] second] isEqual:testInteger3]), @"Failed to insert scaleFactors for testEntity in \"%s\"",__PRETTY_FUNCTION__);
    
    
    XCTAssertTrue([[[self testEntity] exclusions] isEqual: testSet1], @"Exclusions should be a set for testEntity in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue([[[self testEntity] forceGeneration] isEqual:testSet2], @"ForceGeneration should be a set for testEntity in \"%s\"", __PRETTY_FUNCTION__);
}

@end

@interface TestPCGEntityMethods : XCTestCase

@property (nonatomic, strong) PCGEntity* testEntity;
@property (nonatomic) char testSymbol;
@property (nonatomic) NSInteger testFrequency;
@property (nonatomic, strong) PCGIntegerPair* testDimensions;
@property (nonatomic, strong) NSMutableArray* testScaleFactors;
@property (nonatomic, strong) PCGPair* testScaleFactorTypeMap;
@property (nonatomic, strong) PCGDoublePair* testScaleFactor;
@property (nonatomic, strong) NSNumber* testScaleFactorType;
@property (nonatomic) NSInteger testDimensionX;
@property (nonatomic) NSInteger testDimensionY;
@property (nonatomic) double testScaleFactorX;
@property (nonatomic) double testScaleFactorY;
@property (nonatomic, strong) NSMutableSet* testExclusions;
@property (nonatomic, strong) NSMutableSet* testForceGeneration;
@property (nonatomic, strong) NSNumber* testSetMember1;
@property (nonatomic, strong) NSNumber* testSetMember2;
@property (nonatomic, strong) NSNumber* testSetMember3;
@property (nonatomic, strong) NSNumber* testSetMember4;


@end


@implementation TestPCGEntityMethods

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    [self setTestSymbol:'t'];
    [self setTestFrequency: 3];
    
    [self setTestDimensions: mock([PCGIntegerPair class])];
    
    [self setTestDimensionX: 1093];
    [self setTestDimensionY: [self testDimensionX] * (-1)];
    [self setTestScaleFactorType:[[NSNumber alloc] initWithInteger:3]];
    [self setTestScaleFactors: [[NSMutableArray alloc] init]];
    [self setTestScaleFactorTypeMap: mock([PCGPair class])];
    
    [self setTestScaleFactorX: 0.00001];
    [self setTestScaleFactorY: 100.00030];
    
    [self setTestExclusions:[[NSMutableSet alloc] init]];
    [self setTestForceGeneration: [[NSMutableSet alloc] init]];
    
    [self setTestSetMember1:[[NSNumber alloc] initWithInteger: 343]];
    [self setTestSetMember2:[[NSNumber alloc] initWithInteger: 876]];
    [self setTestSetMember3:[[NSNumber alloc] initWithInteger: 3544323]];
    [self setTestSetMember4:[[NSNumber alloc] initWithInteger: -343]];
    
    [[self testExclusions] addObject:[self testSetMember1]];
    [[self testExclusions] addObject:[self testSetMember2]];
    [[self testForceGeneration] addObject:[self testSetMember3]];
    [[self testForceGeneration] addObject:[self testSetMember4]];
    
    [[self testScaleFactors] addObject:[self testScaleFactorTypeMap]];
    
    //Create stubs
    [given([[self testDimensions] first]) willReturnInt:[self testDimensionX]];
    [given([[self testDimensions] second]) willReturnInt:[self testDimensionY]];
    [given([[self testScaleFactor] first]) willReturnDouble:[self testScaleFactorX]];
    [given([[self testScaleFactor] second]) willReturnDouble:[self testScaleFactorY]];
    [given([[self testScaleFactorTypeMap] first]) willReturn:[self testScaleFactor]];
    [given([[self testScaleFactorTypeMap] second]) willReturn: [self testScaleFactorType]];
    [given([[self testScaleFactors] objectAtIndex:0]) willReturn:[self testScaleFactorTypeMap]];
    
    [self
     setTestEntity:
     [[PCGEntity alloc] initWithSymbol:[self testSymbol]
                          andFrequency:[self testFrequency]
                         andDimensions:[self testDimensions]
                       andScaleFactors:[self testScaleFactors]
                         andExclusions:[self testExclusions]
                    andForceGeneration:[self testForceGeneration]]];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [self setTestEntity: nil];
    [super tearDown];
}

-(void) testIsEqual
{
    PCGEntity* mockEntity = mock([PCGEntity class]);

    XCTAssertFalse([[self testEntity] isEqual:mockEntity], @"Uninitialized mock entity should not be equal to initialized test entity in \"%s\"", __PRETTY_FUNCTION__);
    
    [given([mockEntity symbol]) willReturnChar:[self testSymbol]];
    
    XCTAssertTrue([[self testEntity] isEqual: mockEntity], @"Char initialized mock entity should equal test entity in \"%s\"", __PRETTY_FUNCTION__);

    [given([mockEntity frequency]) willReturnInteger: [self testFrequency]];
    [given([mockEntity dimensions]) willReturn: [self testDimensions]];
    [given([mockEntity scaleFactors]) willReturn: [self testScaleFactors]];
    [given([mockEntity exclusions]) willReturn: [self testExclusions]];
    [given([mockEntity forceGeneration]) willReturn: [self testForceGeneration]];
    
    XCTAssertTrue([[self testEntity] isEqual: mockEntity], @"Fully initialized mock entity should equal test entity in \"%s\"", __PRETTY_FUNCTION__);
}

-(void) testIsEqualIntegration
{
    PCGEntity* testEntity2 = [[PCGEntity alloc] initWithSymbol:[self testSymbol] andFrequency:[self testFrequency]];
    XCTAssertTrue([[self testEntity] isEqual: testEntity2], @"Both entity objects should be equal in \"%s\"", __PRETTY_FUNCTION__);
}



@end