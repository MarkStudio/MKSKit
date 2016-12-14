//
//  UIDevice+MKSExtend.m
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#import "UIDevice+MKSExtend.h"

@implementation UIDevice (MKSExtend)

- (MKSDeviceResolution)currentResolution
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale,
                                result.height * [UIScreen mainScreen].scale);
            if (result.height <= 480.0f) {
                return MKS_iPhoneStandardRes;
            }
            else if (result.height <= 960) {
                return MKS_iPhoneHiRes;
            }
            else if (result.height <= 1136) {
                return MKS_iPhoneTallerHiRes;
            }
            else if (result.height < 1440) {
                return MKS_iPhone7pHiRes;
            }
            
            
        }
        else {
            return MKS_iPhoneStandardRes;
        }
    }
    else {
        return (([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) ? MKS_iPadHiRes : MKS_iPadStandardRes);
    }
}//

@end
