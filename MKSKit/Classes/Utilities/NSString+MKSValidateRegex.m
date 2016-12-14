//
//  NSString+MKValidateRegex.m
//  Pods
//
//  Created by Mark Yang on 11/24/15.
//
//

#import "NSString+MKSValidateRegex.h"

@implementation NSString (MKSValidateRegex)

- (BOOL)mksMatchMobileNumber
{
    NSString *mobileRegex = @"^((13[0-9])|(15[^4,\\D])|(17[0,6-8])|(18[0,0-9]))\\d{8}$";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegex];
    
    return [mobilePredicate evaluateWithObject:self];
}//

- (BOOL)mksMatchPassword
{
    NSString *passwordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    
    return [passwordPredicate evaluateWithObject:self];
}//

- (BOOL)mksMatchEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}//

@end
