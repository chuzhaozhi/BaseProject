//
//  BaseProjectUITests.m
//  BaseProjectUITests
//  Created by JackerooChu on 2019/3/5.
//  Copyright © 2019 JackerooChu. All rights reserved.
//
//  
//  If debugging a program bothers you, don't give up. 
//	Success is always around the corner. 
//	You never know how far you are from him unless you come to the corner. 
//	So remember,
//	persevere until you succeed.
//
        

#import <XCTest/XCTest.h>

@interface BaseProjectUITests : XCTestCase

@end

@implementation BaseProjectUITests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;

    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
