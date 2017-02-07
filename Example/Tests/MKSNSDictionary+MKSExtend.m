//
//  MKSNSDictionary+MKSExtend.m
//  MKSKit
//
//  Created by Mark Yang on 20/12/2016.
//  Copyright © 2016 MarkStudio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MKSKit/MKSKit.h>

@interface MKSNSDictionary_MKSExtend : XCTestCase

@end

@implementation MKSNSDictionary_MKSExtend

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testMksDictionaryFromQueryEncoding
{
    NSString *url = @"https://www.baidu.com?a=1&b=2";
    NSURL *urlInstance = [NSURL URLWithString:url];
    NSLog(@"absolute string : %@", urlInstance.absoluteString);
    NSLog(@"base url : %@", urlInstance.baseURL.absoluteString);
    NSLog(@"url scheme : %@", urlInstance.scheme);
    NSLog(@"host : %@", urlInstance.host);
    NSLog(@"query uri : %@", urlInstance.query);
    
    NSDictionary *dicParams = [NSDictionary mksDictionaryFromQuery:urlInstance.query
                                                          encoding:NSUTF8StringEncoding];
    NSLog(@"query params : %@", dicParams);
}//

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
