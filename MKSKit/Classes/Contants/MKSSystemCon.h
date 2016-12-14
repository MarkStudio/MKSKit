//
//  MKSSystemCon.h
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#ifndef MKSSystemCon_h
#define MKSSystemCon_h

#pragma mark - System Version

// OP版本信息比较(如：XXXX_XXXX_TO(@"8.0"))
#define SYSTEM_VERSION_EQUAL_TO(v)      ([[[UIDevice currentDevice] systemVersion] compare:v  \
                                                                                   options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v \
                                                                                   options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v  \
                                                                                              options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v  \
                                                                               options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v \
                                                                                           options:NSNumericSearch] != NSOrderedDescending)
#pragma mark - Bundle

#define MAIN_BUNDLE   [NSBundle mainBundle]

#pragma mark - UserDefaults

#define UDF [NSUserDefaults standardUserDefaults]

#endif /* MKSSystemCon_h */
