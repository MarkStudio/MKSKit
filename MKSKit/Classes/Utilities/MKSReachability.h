//
//  MKSReachability.h
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef NS_ENUM(NSUInteger, MKSNetworkReachabilityStatus) {
    MKSNetworkReachabilityStatusNone = 0,      // not reachable
    MKSNetworkReachabilityStatusWWAN,          // WWAN (2G/3G/4G)
    MKSNetworkReachabilityStatusWiFi,          // WiFi
};

typedef NS_ENUM(NSUInteger, MKSNetworkWWANStatus) {
    MKSNetworkWWANStatusNone = 0,        // not reachable via WWAN
    MKSNetworkWWANStatus2G,              // 2G (GPRS/EDGE)           10-100Kbps
    MKSNetworkWWANStatus3G,              // 3G (WCDMA/HSPDA/...)     1-10Mbps
    MKSNetworkWWANStatus4G,              // 4G (eHRPD/LTE)           100Mbps
};

NS_ASSUME_NONNULL_BEGIN

@interface MKSReachability : NSObject

@property (nonatomic, assign, readonly) SCNetworkReachabilityFlags  flags;                                 // current flags
@property (nonatomic, assign, readonly) MKSNetworkReachabilityStatus status;                               // current status
@property (nonatomic, assign, readonly) MKSNetworkWWANStatus         wwanStatus NS_AVAILABLE_IOS(7_0);     // current WWAN status(手机网络细分)
@property (nonatomic, assign, readonly, getter=isReachable) BOOL    reachable;                             // current reachable status
// notify block will be called on main thread when network status changed
@property (nonatomic, copy) void (^notifyBlock)(MKSReachability *reachability);

#pragma mark -

// create an object to check the reachability of the default route
+ (instancetype)reachability;
// create an object to check the reachability of the local WIFI
+ (instancetype)reachabilityForLocalWiFi;
// create an object to check the reachability of a given host name
+ (instancetype)reachabilityWithHostname:(NSString *)hostname;
// create an object to check the reachability of a given IP address
// @param hostAddress You may pass `struct sockaddr_in` for IPv4 address or `struct sockaddr_in6` for IPv6 address.
+ (instancetype)reachabilityWithAddress:(const struct sockaddr_in *)hostAddress;

@end

NS_ASSUME_NONNULL_END
