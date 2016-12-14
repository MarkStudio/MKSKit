//
//  MKSDeviceContants.h
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#ifndef MKSDeviceCon_h
#define MKSDeviceCon_h

#pragma mark - Device Type

// 判断设备类型
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)           // iPhone
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)               // iPad
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])   // iPod
// iTV
#define IS_ITV (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomTV)  NS_ENUM_AVAILABLE_IOS(9_0)
// Car Play
#define IS_CARPLAY (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomCarPlay)  NS_ENUM_AVAILABLE_IOS(9_0)

#pragma mark - Screen Size

// 屏幕尺寸
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_BOUNDS ([[UIScreen mainScreen] bounds])

#pragma mark - iPhone Type

// 不适配的情况下判不准，comment by mark 16-12-14
// 判断是否为 iPhone 5SE
#define iPhone5SE SCREEN_WIDTH == 320.0f && SCREEN_HEIGHT == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone6_6s SCREEN_WIDTH == 375.0f && SCREEN_HEIGHT == 667.0f
// 判断是否为iPhone 6Plus/6sPlus
#define iPhone6Plus_6sPlus SCREEN_WIDTH == 414.0f && SCREEN_HEIGHT == 736.0f      

#endif /* MKSDeviceContants_h */
