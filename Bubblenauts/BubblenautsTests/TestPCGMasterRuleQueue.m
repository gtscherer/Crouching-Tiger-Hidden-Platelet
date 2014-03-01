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

- (void)testAddRule
{
    PCGRule* testRule = mock([PCGRule class]);
    [given([testRule isEqual:testRule]) willReturnBool:YES];
    
    [[self testRuleList] addRule: testRule];
    
    XCTAssertEqual([[self testRuleList] count], (NSUInteger)1, @"Rule list should be 1 in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertTrue([testRule isEqual:[[[[self testRuleList] rules] objectEnumerator] nextObject]], @"Test rule list should be equal in \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testGetExclusions
{
    NSMutableSet* ruleList = [[NSMutableSet alloc] init];
    for(int i = 0; i < 5; ++i)
    {
        PCGRule* testRule = mock([PCGRule class]);
        [given([testRule ruleType]) willReturnInteger:EXCLUDE];
        [given([testRule entitySymbol]) willReturnChar: (char)i];
        [ruleList addObject: testRule];
    }
    XCTAssertEqual([ruleList count], (NSUInteger)5, @"Rule list should have 5 elements in \"%s\"", __PRETTY_FUNCTION__);
    
    [[self testRuleList] setRules:ruleList];
    
    XCTAssertEqual([[self testRuleList] count], (NSUInteger) 5, @"Test Rule list should have 5 elements in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertEqual([[[self testRuleList] getExclusions] count], (NSUInteger) 5, @"Exclusions should have 5 elements \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testGetForceGeneration
{
    NSMutableSet* ruleList = [[NSMutableSet alloc] init];
    for(int i = 0; i < 5; ++i)
    {
        PCGRule* testRule = mock([PCGRule class]);
        [given([testRule ruleType]) willReturnInteger:FORCE];
        [given([testRule entitySymbol]) willReturnChar: (char)i];
        [ruleList addObject: testRule];
    }
    XCTAssertEqual([ruleList count], (NSUInteger)5, @"Rule list should have 5 elements in \"%s\"", __PRETTY_FUNCTION__);
    
    [[self testRuleList] setRules:ruleList];
    
    XCTAssertEqual([[self testRuleList] count], (NSUInteger) 5, @"Test Rule list should have 5 elements in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertEqual([[[self testRuleList] getForceGenerate] count], (NSUInteger) 5, @"Force  should have 5 elements \"%s\"", __PRETTY_FUNCTION__);
}

@end

@interface TestPCGQueue : XCTestCase

@property (nonatomic, strong) PCGQueue* testQueue;

@end

@implementation TestPCGQueue

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    [self setTestQueue: [[PCGQueue alloc] init]];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [self setTestQueue: nil];
    [super tearDown];
}

- (void) testCount
{
    NSMutableArray* newQueue = [[NSMutableArray alloc] init];
    for(NSInteger i = 0; i < 6; ++i)
    {
        [newQueue addObject:[[NSNumber alloc] initWithInteger:i]];
    }
    
    [[self testQueue] setQueue: newQueue];
    
    XCTAssertEqual([[self testQueue] count], (NSUInteger) 6, @"Queue should be of length 6 \"%s\"", __PRETTY_FUNCTION__);
}

- (void) testObjectInQueueAtIndex
{
    NSMutableArray* newQueue = [[NSMutableArray alloc] init];
    for(NSInteger i = 0; i < 6; ++i)
    {
        [newQueue addObject:[[NSNumber alloc] initWithInteger:i]];
    }
    
    [[self testQueue] setQueue: newQueue];
    
    for(NSInteger i = 0; i < 6; ++i)
    {
        XCTAssertEqual([[[self testQueue] objectInQueueAtIndex:i] integerValue], i, @"Queue objects not equal in \"%s\"", __PRETTY_FUNCTION__);
    }
}

- (void) testEnqueueDequeue
{
    for(NSInteger i = 0; i < 6; ++i)
    {
        [[self testQueue] enqueue: [[NSNumber alloc] initWithInteger:i]];
    }
    
    XCTAssertEqual([[self testQueue] count], (NSUInteger) 6, @"Test Queue should have 5 members in \"%s\"", __PRETTY_FUNCTION__);
    
    for(NSInteger i = 0; i < 6; ++i)
    {
        XCTAssertEqual([[self testQueue] dequeue], [[NSNumber alloc] initWithInteger:i], @"Numbers should match in \"%s\"", __PRETTY_FUNCTION__);
    }
    
    XCTAssertEqual([[self testQueue] count], (NSUInteger) 0, @"Test Queue should be empty in \"%s\"", __PRETTY_FUNCTION__);
    
}
@end

@interface TestPCGRevolver : XCTestCase

@property (nonatomic, strong) PCGRevolver* testRevolver;

@end

@implementation TestPCGRevolver

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    [self setTestRevolver: [[PCGRevolver alloc] init]];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [self setTestRevolver: nil];
    [super tearDown];
}

- (void) testAddObject
{
    for(NSInteger i = 0; i < 6; ++i)
    {
        [[self testRevolver] addObject:[[NSNumber alloc] initWithInteger:i]];
    }
    XCTAssertEqual([[[self testRevolver] circuit] count], (NSUInteger) 6, @"Test revolver should have a circuit of length 6 in \"%s\"", __PRETTY_FUNCTION__);
    
    XCTAssertEqual([[self testRevolver] head], [[NSNumber alloc] initWithInteger:0], @"Head should be first object in \"%s\"", __PRETTY_FUNCTION__);
    
    for(NSInteger i = 0; i < 6; ++i)
    {
        XCTAssertEqual([[[self testRevolver] circuit] objectAtIndex:i], [[NSNumber alloc] initWithInteger:i], @"Objects should be in MutableArray in \"%s\"", __PRETTY_FUNCTION__);
    }
}

- (void) testNext
{
    for(NSInteger i = 0; i < 6; ++i)
    {
        [[self testRevolver] addObject:[[NSNumber alloc] initWithInteger:i]];
    }
    NSMutableArray* expectedResults = [[NSMutableArray alloc] init];
    for(NSInteger j = 0; j < 3; ++j)
    {
        for(NSInteger i = 0; i < 6; ++i)
        {
            [expectedResults addObject:[[NSNumber alloc] initWithInteger:i]];
        }
    }
    
    for(NSInteger i = 0; i < 18; ++i)
    {
        NSNumber* expectedResult = [expectedResults objectAtIndex:i];
        XCTAssertTrue([(NSNumber*)[[self testRevolver] head] isEqual: expectedResult], @"Head should be %d, is %d in \"%s\"",[expectedResult integerValue], [(NSNumber*)[[self testRevolver] head] integerValue],__PRETTY_FUNCTION__);
        XCTAssertTrue([expectedResult isEqual: [[self testRevolver] next]], @"List should repeat 3 times in \"%s\"", __PRETTY_FUNCTION__);
    }
}

- (void) testCount
{
    for(NSInteger i = 0; i < 6; ++i)
    {
        [[[self testRevolver] circuit] addObject:[[NSNumber alloc] initWithInteger:i]];
    }
    XCTAssertEqual([[self testRevolver] count], (NSUInteger) 6, @"Test revolver should be of length 6 in \"%s\"", __PRETTY_FUNCTION__);
}




@end



@interface TestPCGRuleRevolver : XCTestCase

@property (nonatomic, strong) PCGRuleRevolver* testRuleRevolver;

@end


@implementation TestPCGRuleRevolver

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    [self setTestRuleRevolver: [[PCGRuleRevolver alloc] init]];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [self setTestRuleRevolver:nil];
    [super tearDown];
}

- (void) testCreateAndAddQueue
{
    XCTAssertEqual([[self testRuleRevolver] count], (NSUInteger) 0, @"Initial state should be 0 in \"%s\"", __PRETTY_FUNCTION__);
    
    [[self testRuleRevolver] createAndAddQueue];
    
    XCTAssertEqual([[self testRuleRevolver] count], (NSUInteger) 1, @"Should have 1 queue in \"%s\"", __PRETTY_FUNCTION__);
    
    [[self testRuleRevolver] createAndAddQueue];
    
    XCTAssertEqual([[self testRuleRevolver] count], (NSUInteger) 2, @"Should have 2 queue in \"%s\"", __PRETTY_FUNCTION__);
}

- (void) testAddObject
{
    PCGQueue* testQueue = mock([PCGQueue class]);
    
    [[self testRuleRevolver] addObject:testQueue];
    
    XCTAssertEqual([[self testRuleRevolver] count], (NSUInteger) 1, @"Rule revolver should have \"%s\"", __PRETTY_FUNCTION__);
    XCTAssertEqualObjects([[[self testRuleRevolver] circuit] objectAtIndex:0], testQueue, @"Rule queue should be in testRuleRevolver in \"%s\"", __PRETTY_FUNCTION__);
}

- (void) testAddObjectAtIndex
{
    PCGQueue* testQueue = [[PCGQueue alloc] init];
    
    NSNumber* testNumber = [[NSNumber alloc] initWithInteger:5];
    
    [[self testRuleRevolver] addObject:testQueue];

    [[self testRuleRevolver] addObject:testNumber toQueueAtIndex:0];
    
    XCTAssertTrue([testNumber isEqual:[(PCGQueue*) [[[self testRuleRevolver] circuit] objectAtIndex:0] dequeue]], @"Number should be stored in queue in circuit in \"%s\"", __PRETTY_FUNCTION__);
}

- (void) testObjectInQueueAtIndex
{
    PCGQueue* testQueue = [[PCGQueue alloc] init];
    
    NSNumber* testNumber = [[NSNumber alloc] initWithInteger:4];
        
    [[self testRuleRevolver] addObject:testQueue];
    
    [[self testRuleRevolver] addObject:testNumber toQueueAtIndex:0];
    
    NSNumber* testNumber2 = [[self testRuleRevolver] objectInQueueAtIndex:0 inColumn:0];
    
    XCTAssertEqualObjects(testNumber, testNumber2, @"Objects should be the same in \"%s\"", __PRETTY_FUNCTION__);
}


@end