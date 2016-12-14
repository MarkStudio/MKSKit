//
//  MKSReachability.m
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#import "MKSReachability.h"
#import <objc/message.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

static MKSNetworkReachabilityStatus MKSReachabilityStatusFromFlags(SCNetworkReachabilityFlags flags, BOOL allowWWAN) {
    if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
        return MKSNetworkReachabilityStatusNone;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) &&
        (flags & kSCNetworkReachabilityFlagsTransientConnection)) {
        return MKSNetworkReachabilityStatusNone;
    }
    
    if ((flags & kSCNetworkReachabilityFlagsIsWWAN) && allowWWAN) {
        return MKSNetworkReachabilityStatusWWAN;
    }
    
    return MKSNetworkReachabilityStatusWiFi;
}

static void MKSReachabilityCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info) {
    MKSReachability *self = ((__bridge MKSReachability *)info);
    if (self.notifyBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.notifyBlock(self);
        });
    }
}

#pragma mark -

@interface MKSReachability ()

@property (nonatomic, assign) SCNetworkReachabilityRef ref;
@property (nonatomic, assign) BOOL scheduled;
@property (nonatomic, assign) BOOL allowWWAN;
@property (nonatomic, strong) CTTelephonyNetworkInfo *networkInfo;

@end

#pragma mark -

@implementation MKSReachability

+ (dispatch_queue_t)sharedQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.markstudio.mkskit.reachability", DISPATCH_QUEUE_SERIAL);
    });
    
    return queue;
}

#pragma mark -

- (void)setScheduled:(BOOL)scheduled
{
    if (_scheduled == scheduled) return;
    _scheduled = scheduled;
    if (scheduled) {
        SCNetworkReachabilityContext context = { 0, (__bridge void *)self, NULL, NULL, NULL };
        SCNetworkReachabilitySetCallback(self.ref, MKSReachabilityCallback, &context);
        SCNetworkReachabilitySetDispatchQueue(self.ref, [self.class sharedQueue]);
    }
    else {
        SCNetworkReachabilitySetDispatchQueue(self.ref, NULL);
    }
}

- (SCNetworkReachabilityFlags)flags
{
    SCNetworkReachabilityFlags flags = 0;
    SCNetworkReachabilityGetFlags(self.ref, &flags);
    
    return flags;
}

- (MKSNetworkReachabilityStatus)status
{
    return MKSReachabilityStatusFromFlags(self.flags, self.allowWWAN);
}

- (MKSNetworkWWANStatus)wwanStatus
{
    if (!self.networkInfo) return MKSNetworkWWANStatusNone;
    NSString *status = self.networkInfo.currentRadioAccessTechnology;
    if (!status) return MKSNetworkWWANStatusNone;
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{CTRadioAccessTechnologyGPRS : @(MKSNetworkWWANStatus2G),  // 2.5G   171Kbps
                CTRadioAccessTechnologyEdge : @(MKSNetworkWWANStatus2G),  // 2.75G  384Kbps
                CTRadioAccessTechnologyWCDMA : @(MKSNetworkWWANStatus3G), // 3G     3.6Mbps/384Kbps
                CTRadioAccessTechnologyHSDPA : @(MKSNetworkWWANStatus3G), // 3.5G   14.4Mbps/384Kbps
                CTRadioAccessTechnologyHSUPA : @(MKSNetworkWWANStatus3G), // 3.75G  14.4Mbps/5.76Mbps
                CTRadioAccessTechnologyCDMA1x : @(MKSNetworkWWANStatus3G), // 2.5G
                CTRadioAccessTechnologyCDMAEVDORev0 : @(MKSNetworkWWANStatus3G),
                CTRadioAccessTechnologyCDMAEVDORevA : @(MKSNetworkWWANStatus3G),
                CTRadioAccessTechnologyCDMAEVDORevB : @(MKSNetworkWWANStatus3G),
                CTRadioAccessTechnologyeHRPD : @(MKSNetworkWWANStatus3G),
                CTRadioAccessTechnologyLTE : @(MKSNetworkWWANStatus4G)}; // LTE:3.9G 150M/75M  LTE-Advanced:4G 300M/150M
    });
    NSNumber *num = dic[status];
    
    return num ? num.unsignedIntegerValue : MKSNetworkWWANStatusNone;
}

- (void)dealloc {
    self.notifyBlock = nil;
    self.scheduled = NO;
    CFRelease(self.ref);
}

- (void)setNotifyBlock:(void (^)(MKSReachability *reachability))notifyBlock
{
    _notifyBlock = [notifyBlock copy];
    self.scheduled = (self.notifyBlock != nil);
}

- (BOOL)isReachable
{
    return self.status != MKSNetworkReachabilityStatusNone;
}

+ (instancetype)reachability
{
    return self.new;
}

+ (instancetype)reachabilityForLocalWifi
{
    struct sockaddr_in localWifiAddress;
    bzero(&localWifiAddress, sizeof(localWifiAddress));
    localWifiAddress.sin_len = sizeof(localWifiAddress);
    localWifiAddress.sin_family = AF_INET;
    localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);
    MKSReachability *one = [self reachabilityWithAddress:(const struct sockaddr *)&localWifiAddress];
    one.allowWWAN = NO;
    
    return one;
}

+ (instancetype)reachabilityWithHostname:(NSString *)hostname
{
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [hostname UTF8String]);
    return [[self alloc] initWithRef:ref];
}

+ (instancetype)reachabilityWithAddress:(const struct sockaddr *)hostAddress
{
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)hostAddress);
    return [[self alloc] initWithRef:ref];
}

- (instancetype)init
{
    /*
     See Apple's Reachability implementation and readme:
     The address 0.0.0.0, which reachability treats as a special token that
     causes it to actually monitor the general routing status of the device,
     both IPv4 and IPv6.
     https://developer.apple.com/library/ios/samplecode/Reachability/Listings/ReadMe_md.html#//apple_ref/doc/uid/DTS40007324-ReadMe_md-DontLinkElementID_11
     */
    struct sockaddr_in zero_addr;
    bzero(&zero_addr, sizeof(zero_addr));
    zero_addr.sin_len = sizeof(zero_addr);
    zero_addr.sin_family = AF_INET;
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zero_addr);
    return [self initWithRef:ref];
}

- (instancetype)initWithRef:(SCNetworkReachabilityRef)ref
{
    if (!ref) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _ref = ref;
        _allowWWAN = YES;
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) {
            _networkInfo = [[CTTelephonyNetworkInfo alloc] init];
        }
    }
    
    return self;
}//

@end
