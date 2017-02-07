//
//  MKSAppInfo.m
//  Pods
//
//  Created by Mark Yang on 15/12/2016.
//
//

#import "MKSAppInfo.h"
#import "MKSSystemCon.h"

static NSString *kAppInfoURL = @"https://itunes.apple.com/lookup?id=";
static NSString *firstLaunchKey = @"MKSAppInfoFirstLauchKey";

@implementation MKSAppInfo

+ (BOOL)isFirstLaunch
{
    BOOL hadBeenLaunch = [UDF boolForKey:firstLaunchKey];
    if (NO == hadBeenLaunch) {
        hadBeenLaunch = YES;    // current been launched
        [UDF setBool:hadBeenLaunch forKey:firstLaunchKey];
        [NSUserDefaults resetStandardUserDefaults];

        return YES;     // 第一次启动
    }
    
    return NO;          // 非第一次启动
}//

+ (BOOL)resetFirstLaunch
{
    [UDF removeObjectForKey:firstLaunchKey];
    [NSUserDefaults resetStandardUserDefaults];
}//

+ (NSString *)appName;
{
    NSString *strAppName = [MAIN_BUNDLE_INFO objectForKey:kCFBundleNameKey];
    
    return strAppName;
}//

+ (NSString *)currentAppVersion
{
    NSString *strCurAppVersion = [MAIN_BUNDLE_INFO objectForKey:@"CFBundleShortVersionString"];
    
    return strCurAppVersion;
}//

+ (NSString *)currentBuildVersion
{
    NSString *buildVersion = [MAIN_BUNDLE_INFO objectForKey:kCFBundleVersionKey];
    
    return buildVersion;
}//

#pragma mark -

+ (MKSAppInfo *)sharedManager
{
    static MKSAppInfo *__sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedManager = [[MKSAppInfo alloc] init];
    });
    
    return __sharedManager;
}//

- (void)requestAppVersionInfoInAppStoreWithAppID:(NSString *)appID
                                  withErrorBlock:(RequestAppVersionInfoErrorBlock)aErrorBlock
                                 withFinishBlock:(RequestAppVersionInfoDidFinishBlock)aFinishBlock
{
    [self setRequestErrorBlock:aErrorBlock];
    [self setRequestFinishBlock:aFinishBlock];
    [self sendAppStoreVersionRequestWithAppID:appID];
}//

#pragma mark -
#pragma mark Private Methods

- (void)sendAppStoreVersionRequestWithAppID:(NSString *)appID
{
    if (appID.length < 1) {
        NSLog(@"======获取AppInfo时AppID不能为空======");
        
        return;
    }
    
    NSString *strUrl = [NSString stringWithFormat:@"%@%@", kAppInfoURL, appID];
//    NSString *strUrl = @"https://www.baidu.com/";
    NSURL *url = [[NSURL alloc] initWithString:strUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:url
                                    completionHandler:^(NSData * _Nullable data,
                                                        NSURLResponse * _Nullable response,
                                                        NSError * _Nullable error) {
                                        if (error) {
                                            _requestErrorBlock(error);
                                        }
                                        else {
                                            NSDictionary *dicRes = [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions
                                                                                                     error:&error];
                                            _requestFinishBlock(dicRes, error);
                                        }
                                    }];
    [task resume];
}//

@end
