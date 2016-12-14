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

@interface MKSViewController ()

@end

@implementation MKSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [MKSKitInfo info];
    
    [self testContants];
    
    [self testCustomUI];
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
    MKSRootViewController *vc = [[MKSRootViewController alloc] init];
    UINavigationController *vcNav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vcNav
                       animated:YES
                     completion:nil];
}//

@end
