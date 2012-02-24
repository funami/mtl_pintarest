//
//  pintarestTests.m
//  pintarestTests
//
//  Created by Funami Takao on 12/02/24.
//  Copyright (c) 2012年 Recruit. All rights reserved.
//

#import "pintarestTests.h"
#import "MTLPinModelManager.h"

@implementation pintarestTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    // シングルトン
    MTLPinModelManager *mgr = [MTLPinModelManager sharedManager];
    MTLPinModelManager *mgr2 = [MTLPinModelManager sharedManager];
    STAssertEquals(mgr, mgr2,@"シングルトンであることを確認する");
    
    NSArray *pins = [mgr searchPins:@"osaka"];
    
    STAssertEquals([pins count], (NSUInteger)0,@"osakaで検索したときのモデルのサイズ");
    
    pins = [mgr searchPins:@"station"];
    
    //STAssertEquals([pins count], (NSUInteger)10,@"stationで検索したときのモデルのサイズ");
    
}

@end
