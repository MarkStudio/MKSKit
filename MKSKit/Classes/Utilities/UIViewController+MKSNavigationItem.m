//
//  UIViewController+MKNavigationItem.m
//  SkyUtils
//
//  Created by Mark Yang on 11/18/15.
//  Copyright © 2015 MissionSky. All rights reserved.
//

#import "UIViewController+MKSNavigationItem.h"
#import "UIImage+MKSExtend.h"
 
@implementation UIViewController (MKSNavigationItem)

- (void)mksCustomNavigationTitleView:(UIView *)titleView
{
    if (nil == titleView) {
        [self.navigationItem setTitleView:titleView];
    }
}//

- (void)mksCustomBackItem:(SEL)aSelector
{
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 44)];
    UIImage *image = [UIImage mksBundleImageNamed:@"backArrow"];
    [btnBack setImage:image
             forState:UIControlStateNormal];
    [btnBack setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [btnBack addTarget:self
                action:aSelector
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    [self.navigationItem setLeftBarButtonItem:backBarItem];
}//

@end
