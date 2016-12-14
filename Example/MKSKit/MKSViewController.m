//
//  MKSViewController.m
//  MKSKit
//
//  Created by MarkStudio on 12/14/2016.
//  Copyright (c) 2016 MarkStudio. All rights reserved.
//

#import "MKSViewController.h"

#import <MKSKit/MKSKit.h>

@interface MKSViewController ()

@end

@implementation MKSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [MKSKitInfo info];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
