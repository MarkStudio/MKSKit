//
//  UITabBarController+MKExtend.m
//  Pods
//
//  Created by Mark Yang on 12/7/15.
//
//

#import "UITabBarController+MKSExtend.h"
#import "UIView+MKSExtend.h"
#import "MKSDeviceCon.h"

#define kAnimationDuration .25

#pragma mark -

@implementation UITabBarController (MKSExtend)

- (BOOL)isTabBarHidden
{
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    return tabBarFrame.origin.y >= viewFrame.size.height;
}


- (void)setTabBarHidden:(BOOL)hidden
{
    [self setTabBarHidden:hidden animated:NO];
}


- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    BOOL isHidden = self.tabBarHidden;
    if(hidden == isHidden)
        return;
    UIView *transitionView = [[[self.view.subviews reverseObjectEnumerator] allObjects] lastObject];
    if(transitionView == nil) {
        NSLog(@"could not get the container view!");
        return;
    }
    CGRect viewFrame = self.view.frame;
    CGRect tabBarFrame = self.tabBar.frame;
    CGRect containerFrame = transitionView.frame;
    tabBarFrame.origin.y = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    containerFrame.size.height = viewFrame.size.height - (hidden ? 0 : tabBarFrame.size.height);
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         self.tabBar.frame = tabBarFrame;
                         transitionView.frame = containerFrame;
                     }
     ];
}

- (void)hideTabBar:(BOOL)hidden
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kAnimationDuration];
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setMksY:(hidden ? SCREEN_HEIGHT : (SCREEN_HEIGHT-49))];
        }
        else if ([view isKindOfClass:NSClassFromString(@"UITransitionView")]){
            [view setMksHeight:(hidden ? SCREEN_HEIGHT : (SCREEN_HEIGHT-49))];
        }
    }
    
    [UIView commitAnimations];
}//

@end
