//
//  TestPCGPair.m
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

@interface TestPCGPair : XCTestCase

@property (nonatomic, strong) PCGPair* testPair;
@property (nonatomic, strong) PCGIntegerPair* testIntegerPair;
@property (nonatomic, strong) PCGDoublePair* testDoublePair;

@end

@implementation TestPCGPair

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

- (void) testPCGPairFirst
{
    
    //Initialize object under test
    [self setTestPair:[[PCGPair alloc] init]];

    //Make sure first is nil, as it should be
    XCTAssertNil([[self testPair] first], @"Initial state should be nil for testPair.first in \"%s\"", __PRETTY_FUNCTION__);
    
    //Create mock object -> avoids issues with errors in dependencies
    PCGPair* mockPair = mock([PCGPair class]);
    
    
    //Regardless of what [mockPair first] would evaluate to,
    //this will return @"TestString" when called by our
    //real object under test.
    //
    //This is called a stub.
    [given([mockPair first]) willReturn:@"TestString"];

    [[self testPair] setFirst: mockPair];
    
    //Set to nil
    mockPair = nil;
    
    //Set to first element of pair
    mockPair = (PCGPair*) [[self testPair] first];
    
    //First element should be our mock object
    //with the stub that returns @"TestString"
    XCTAssertEqual((NSString*) [mockPair first], @"TestString", @"testPair.first not storing/retrieving object in \"%s\"", __PRETTY_FUNCTION__);
    
    //Remove pointer reference so ARC can clean up
    [self setTestPair: nil] ;
    
}

- (void) testPCGPairSecond
{
    
    //Initialize object under test
    [self setTestPair:[[PCGPair alloc] init]];
    
    //Make sure first is nil, as it should be
    XCTAssertNil([[self testPair] second], @"Initial state should be nil for testPair.second in \"%s\"", __PRETTY_FUNCTION__);
    
    //Create mock object -> avoids issues with errors in dependencies
    PCGPair* mockPair = mock([PCGPair class]);
    
    [given([mockPair second]) willReturn:@"TestString"];
    
    [[self testPair] setSecond: mockPair];
    
    //Set to nil
    mockPair = nil;
    
    //Set to first element of pair
    mockPair = (PCGPair*) [[self testPair] second];
    
    //First element should be our mock object
    XCTAssertEqual((NSString*) [mockPair second], @"TestString", @"testPair.second not storing/retrieving object in \"%s\"", __PRETTY_FUNCTION__);
    
    //Make sure nothing happened to first
    XCTAssertNil([[self testPair] first], @"First never set, should be nil in \"%s\"", __PRETTY_FUNCTION__);

    
    //Remove pointer reference so ARC can clean up
    [self setTestPair: nil] ;
    
}

- (void) testPCGIntegerPairFirst
{
    [self setTestIntegerPair:[[PCGIntegerPair alloc] init]];

    
    //Assert nil only compatible with Object types
    if([[self testIntegerPair] first])
    {
        XCTFail(@"Initial state should be 0 for testIntegerPair.first in \"%s\"", __PRETTY_FUNCTION__);
    }
    NSInteger testInteger = 5;
    
    [[self testIntegerPair] setFirst:testInteger];
    
    XCTAssertEqual([[self testIntegerPair] first], testInteger, @"testIntegerPair.first not storing/recieving NSInteger in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertEqual([[self testIntegerPair] second], 0, @"Second never set, should be initial value in \"%s\"", __PRETTY_FUNCTION__);

    
    [self setTestIntegerPair: nil];
    
}

- (void) testPCGIntegerPairSecond
{
    [self setTestIntegerPair:[[PCGIntegerPair alloc] init]];
    
    
    //Assert nil only compatible with Object types
    if([[self testIntegerPair] second])
    {
        XCTFail(@"Initial state should be 0 for testIntegerPair.second in \"%s\"", __PRETTY_FUNCTION__);
    }
    NSInteger testInteger = 10000;
    
    [[self testIntegerPair] setSecond:testInteger];
    
    XCTAssertEqual([[self testIntegerPair] second], testInteger, @"testIntegerPair.second not storing/recieving NSInteger in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertEqual([[self testIntegerPair] first], 0, @"First never set, should be initial value in \"%s\"", __PRETTY_FUNCTION__);
    
    [self setTestIntegerPair: nil];
    
}

- (void) testPCGDoublePairFirst
{
    [self setTestDoublePair:[[PCGDoublePair alloc] init]];
    
    if([[self testDoublePair] first])
    {
        XCTFail(@"Initial state should be nil for testDoublePair.first in \"%s\"", __PRETTY_FUNCTION__);
    }
    
    double testDouble = 5.00;
    
    [[self testDoublePair] setFirst:testDouble];
    
    XCTAssertEqual([[self testDoublePair] first], testDouble, @"testDoublePair.first not storing/recieving NSInteger in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertEqual([[self testIntegerPair] second], 0, @"Second never set, should be initial value in \"%s\"", __PRETTY_FUNCTION__);

    [self setTestDoublePair: nil];

}

- (void) testPCGDoublePairSecond
{
    [self setTestDoublePair:[[PCGDoublePair alloc] init]];
    
    if([[self testDoublePair] second])
    {
        XCTFail(@"Initial state should be nil for testDoublePair.second in \"%s\"", __PRETTY_FUNCTION__);
    }
    
    double testDouble = 5.00;
    
    [[self testDoublePair] setSecond:testDouble];
    
    XCTAssertEqual([[self testDoublePair] second], testDouble, @"testDoublePair.second not storing/recieving NSInteger in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertEqual([[self testIntegerPair] first], 0, @"First never set, should be initial value in \"%s\"", __PRETTY_FUNCTION__);
    
    [self setTestDoublePair: nil];
    
}

- (void) testPCGPairInitialzeWithObjects
{
    [self setTestPair: [[PCGPair alloc] initWithObjects:@"TestString1" secondObject:@"TestString2"]];
    
    XCTAssertEqual([[self testPair] first], @"TestString1", @"Should set first member to TestString1 in \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertEqual([[self testPair] second], @"TestString2", @"Should set second member to TestString2 in \"%s\"", __PRETTY_FUNCTION__);
    
    [self setTestPair: nil];
}

- (void) testPCGIntegerPairInitializeWithIntegers
{
    [self setTestIntegerPair:[[PCGIntegerPair alloc] initWithIntegers:4 secondInteger:5]];
    
    XCTAssertEqual([[self testIntegerPair] first], 4, @"Should set first member to 4 in \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertEqual([[self testIntegerPair] second], 5, @"Should set second member to 5 in \"%s\"", __PRETTY_FUNCTION__);
    
    [self setTestIntegerPair: nil];
}

- (void) testPCGDoublePairInitializeWithDoubles
{
    [self setTestDoublePair:[[PCGDoublePair alloc] initWithDoubles:5.68 secondDouble:9.12]];
    
    XCTAssertEqual([[self testDoublePair] first], 5.68, @"Should set first member to 5.68 in \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertEqual([[self testDoublePair] second], 9.12, @"Should set first member to 9.12 in \"%s\"", __PRETTY_FUNCTION__);
    
    [self setTestDoublePair: nil];
}

- (void) testPCGPairEquals
{
    NSString* testString1 = [NSString stringWithFormat:@"TestString1"];
    NSString* testString2 = [NSString stringWithFormat:@"TestString2"];
    
    //Create object to test
    [self setTestPair: [[PCGPair alloc] initWithObjects:testString1 secondObject:testString2]];
    
    //Create mock objects
    PCGPair* mockObject = mock([PCGPair class]);
    
    //Create stubs
    [given([mockObject first]) willReturn:testString1];
    [given([mockObject second]) willReturn:testString2];
    
    XCTAssertTrue([[self testPair] isEqual: mockObject], @"Should equal mock object in \"%s\"", __PRETTY_FUNCTION__);
    
    [self setTestPair: nil];
}

- (void) testPCGIntegerPairEquals
{
    NSInteger testInteger1 = 4567654;
    NSInteger testInteger2 = 9847483;
    
    [self setTestIntegerPair: [[PCGIntegerPair alloc] initWithIntegers:testInteger1 secondInteger:testInteger2]];
    
    PCGIntegerPair* mockIntegerPair = mock([PCGIntegerPair class]);
    [given([mockIntegerPair first]) willReturnInt:testInteger1];
    [given([mockIntegerPair second]) willReturnInt:testInteger2];
    
    XCTAssertTrue([[self testIntegerPair] isEqual: mockIntegerPair], @"All pairs could not be compared in \"%s\"", __PRETTY_FUNCTION__);

    [self setTestIntegerPair: nil];
}

- (void) testPCGDoublePairEquals
{
    double testDouble1 = 1.958569694;
    double testDouble2 = 3.59684884;
    
    [self setTestDoublePair:[[PCGDoublePair alloc] initWithDoubles:testDouble1 secondDouble:testDouble2]];
    
    PCGDoublePair* mockDoublePair = mock([PCGDoublePair class]);
    
    [given([mockDoublePair first]) willReturnDouble: testDouble1];
    [given([mockDoublePair second]) willReturnDouble:testDouble2];
   
    XCTAssertTrue([[self testDoublePair] isEqual: mockDoublePair], @"All pairs could not be compared in \"%s\"", __PRETTY_FUNCTION__);
    
    [self setTestDoublePair: nil];
}

- (void) testAllPCGPairEquals
{
    double testDouble1 = 2.45644;
    double testDouble2 = 5.991812;
    
    NSInteger testInteger1 = 991;
    NSInteger testInteger2 = 12445;
    
    [self setTestDoublePair: [[PCGDoublePair alloc] initWithDoubles:testDouble1 secondDouble:testDouble2]];
    [self setTestIntegerPair: [[PCGIntegerPair alloc] initWithIntegers:testInteger1 secondInteger:testInteger2]];
    [self setTestPair: [[PCGPair alloc] initWithObjects:[self testDoublePair] secondObject:[self testIntegerPair]]];
    
    //Create Mock Objects
    PCGPair* mockPair = mock([PCGPair class]);
    PCGIntegerPair* mockIntegerPair = mock([PCGIntegerPair class]);
    PCGDoublePair* mockDoublePair = mock([PCGDoublePair class]);
    
    //Create Stubs
    [given([mockIntegerPair first]) willReturnInt:testInteger1];
    [given([mockIntegerPair second]) willReturnInt:testInteger2];
    
    [given([mockDoublePair first]) willReturnDouble:testDouble1];
    [given([mockDoublePair second]) willReturnDouble:testDouble2];
    
    
    [given([mockPair first]) willReturn: mockDoublePair];
    [given([mockPair second]) willReturn: mockIntegerPair];
    
    XCTAssertTrue([[self testPair] isEqual: mockPair], @"All pair types could not be compared in \"%s\"", __PRETTY_FUNCTION__);
    [self setTestDoublePair: nil];
    [self setTestIntegerPair: nil];
    [self setTestPair: nil];
    
}

@end
