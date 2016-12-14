//
//  BanPasteTextField.m
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#import "MKSBanPasteTextField.h"

@implementation MKSBanPasteTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    // never show the UIMenuController instance
    return NO;
}//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
