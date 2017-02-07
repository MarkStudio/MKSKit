//
//  MKSAppInfo.m
//  MKSKit
//
//  Created by Mark Yang on 15/12/2016.
//  Copyright © 2016 MarkStudio. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <MKSKit/MKSKit.h>

@interface MKSAppInfoTests : XCTestCase

@end

@implementation MKSAppInfoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testIsFirstLaunch
{
    [MKSAppInfo resetFirstLaunch];
    XCTAssertTrue([MKSAppInfo isFirstLaunch], @"AppInfo App is not first launch.");
    XCTAssertFalse([MKSAppInfo isFirstLaunch], @"AppInfo App has't been lauched.");
}//

- (void)testAppName
{
    XCTAssertNotNil([MKSAppInfo appName], @"AppInfo AppName can't be empty.");
}

- (void)testCurrentAppVersion
{
    XCTAssertNotNil([MKSAppInfo currentAppVersion], @"AppInfo version get error.");
    NSLog(@"Current App version : %@", [MKSAppInfo currentAppVersion]);
}//

- (void)testCurrentBuildVersion
{
    XCTAssertNotNil([MKSAppInfo currentBuildVersion], @"AppInfo build version get error.");
    NSLog(@"Current App build version : %@", [MKSAppInfo currentBuildVersion]);
}//

- (void)testRequestVersion
{
    NSString *appID = @"492840294";
    MKSAppInfo *appInfo = [MKSAppInfo sharedManager];
    [appInfo requestAppVersionInfoInAppStoreWithAppID:appID
                                       withErrorBlock:^(NSError *aError) {
                                           //NSLog(@"Version info : %@", aError);
                                       }
                                      withFinishBlock:^(NSDictionary *aDicInfo,
                                                        NSError *aError) {
                                          //NSLog(@"Version info : %@", aDicInfo);
                                      }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
    }];
}

@end
