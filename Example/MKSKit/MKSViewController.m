//
//  MKSViewController.m
//  MKSKit
//
//  Created by MarkStudio on 12/14/2016.
//  Copyright (c) 2016 MarkStudio. All rights reserved.
//

#import "MKSViewController.h"
#import "MKSRootViewController.h"
#import <MKSKit/MKSKit.h>
#import "QRCodeScanViewController.h"

@interface MKSViewController ()

@end

@implementation MKSViewController

- (void)viewDidLoad
{
    

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [MKSKitInfo info];
    
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
    
    [self testContants];
    
    [self testCustomUI];
    
    [self testAppInfo];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Contants

- (void)testContants
{
    [self testDeviceCon];
    [self testSystemCon];
}//

- (void)testDeviceCon
{
    NSLog(@"iPhone scale : %f", [[UIScreen mainScreen] scale]);
    //NSLog(@"iPhone scale : %i", [[UIScreen mainScreen] scale] == 3.0f);
    NSLog(@"screen width : %@, height : %@", @(SCREEN_WIDTH), @(SCREEN_HEIGHT));
    NSLog(@"is iPhone 5 SE ? %@", @(iPhone5SE));
    NSLog(@"is iPhone 6 Plus ? %@", @(iPhone6Plus_6sPlus));
    
    NSLog(@"Current Resolution : %ld", (long)([[UIDevice currentDevice] currentResolution]));
}

- (void)testSystemCon
{
    NSLog(@"%@", @(SYSTEM_VERSION_GREATER_THAN(@"7.0")));
}//

#pragma mark - Custom UI

- (void)testCustomUI
{
    CGFloat kLeftPadding = 15;
    MKSBanPasteTextField *textField = [[MKSBanPasteTextField alloc] initWithFrame:CGRectMake(kLeftPadding,
                                                                                             40,
                                                                                             SCREEN_WIDTH-2*kLeftPadding,
                                                                                             40)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setText:@"Ban Paste Text"];
    [self.view addSubview:textField];
    
    MKSToggleButton *toggle = [MKSToggleButton buttonWithOnImage:[UIImage imageNamed:@"on"]
                                                        offImage:[UIImage imageNamed:@"off"]
                                                highlightedImage:[UIImage imageNamed:@"highlighted"]];
    [toggle setFrame:CGRectMake(kLeftPadding, 100, 30, 30)];
    [toggle addTarget:self
               action:@selector(transfer:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toggle];
}//

- (void)transfer:(id)sender
{
//    MKSRootViewController *vc = [[MKSRootViewController alloc] init];
//    UINavigationController *vcNav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [self presentViewController:vcNav
//                       animated:YES
//                     completion:nil];
    
//    NSArray *arrMetaObjectTypes = @[AVMetadataObjectTypeQRCode,                // 二维码
//                                    AVMetadataObjectTypeEAN13Code,             // 条形码
//                                    AVMetadataObjectTypeEAN8Code,
//                                    AVMetadataObjectTypeCode39Code,
//                                    AVMetadataObjectTypeCode39Mod43Code,
//                                    AVMetadataObjectTypeCode128Code];
//    if ([MKSQRCodeReader supportsMetadataObjectTypes:arrMetaObjectTypes]) {
//        //        static MKQRCodeReaderViewController *vc = nil;
//        static QRCodeScanViewController *vc = nil;
//        static dispatch_once_t onceToken;
//        
//        dispatch_once(&onceToken, ^{
//            MKSQRCodeReader *reader = [MKSQRCodeReader readerWithMetadataObjectTypes:arrMetaObjectTypes];
//            vc = [[QRCodeScanViewController alloc] initWithCancelButtonTitle:@"取消"
//                                                                  codeReader:reader
//                                                         startScanningAtLoad:YES
//                                                      showSwitchCameraButton:YES
//                                                             showTorchButton:YES];
//            vc.modalPresentationStyle = UIModalPresentationFormSheet;
//        });
////        [vc setDelegate:self];
//        [self presentViewController:vc animated:YES completion:NULL];
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                        message:@"Reader not supported by the current device"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        
//        [alert show];
//    }
    
//    [self presentViewController:[MKSScanViewController defaultQRScanController]
//                       animated:YES
//                     completion:NULL];
}//

- (void)testAppInfo
{
//    NSString *appID = @"492840294";
//    MKSAppInfo *appInfo = [MKSAppInfo sharedManager];
//    [appInfo requestAppVersionInfoInAppStoreWithAppID:appID
//                                       withErrorBlock:^(NSError *aError) {
//                                           NSLog(@"Version info : %@", aError);
//                                       }
//                                      withFinishBlock:^(NSDictionary *aDicInfo,
//                                                        NSError *aError) {
//                                          NSLog(@"Version 001 info : %@", aDicInfo);
//                                      }];
}//

@end
