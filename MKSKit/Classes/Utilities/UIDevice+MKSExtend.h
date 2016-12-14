//
//  UIDevice+MKSExtend.h
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MKSDeviceResolution) {
    MKS_iPhoneResUnknown       = 0,
    MKS_iPhoneStandardRes      = 1,    // iPhone 1,3,3GS 标准分辨率(320x480px)
    MKS_iPhoneHiRes            = 2,    // iPhone 4,4S 高清分辨率(640x960px)
    MKS_iPhoneTallerHiRes      = 3,    // iPhone 5+ 高清分辨率(640x1136px)
    MKS_iPhone7pHiRes          = 4,    // iPhone 7p 高清分辨率(960x1440px)
    MKS_iPadStandardRes,               // iPad 1,2 标准分辨率(1024x768px)
    MKS_iPadHiRes,                     // iPad 3 High Resolution(2048x1536px)
};

@interface UIDevice (MKSExtend)

/**
 *	@brief	当前分辨率
 *
 *	@return	当前分辨率类型
 *
 *	Created by Mark on 2016-12-14 19:15
 */
- (MKSDeviceResolution)currentResolution;

@end
