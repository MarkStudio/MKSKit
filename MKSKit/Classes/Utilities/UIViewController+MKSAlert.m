//
//  UIViewController+MKAlert.m
//  SkyUtils
//
//  Created by Mark Yang on 11/18/15.
//  Copyright © 2015 MissionSky. All rights reserved.
//

#import "UIViewController+MKSAlert.h"

@implementation UIViewController (MKSAlert)

+ (void)mksShowAlertView:(NSString *)title withMessage:(NSString *)message
{
    [self mksShowAlertView:title
               withMessage:message
              withDelegate:nil];
}//

+ (void)mksShowAlertView:(NSString *)title
             withMessage:(NSString *)message
            withDelegate:(id<UIAlertViewDelegate>)delegate;
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    });
}//

@end
