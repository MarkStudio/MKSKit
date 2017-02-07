//
//  MKSAppInfo.h
//  Pods
//
//  Created by Mark Yang on 15/12/2016.
//
//

#import <Foundation/Foundation.h>

typedef void (^RequestAppVersionInfoErrorBlock)(NSError *aError);
typedef void (^RequestAppVersionInfoDidFinishBlock)(NSDictionary *aDicInfo, NSError *aError);

#pragma mark -

@interface MKSAppInfo : NSObject

@property (nonatomic, copy) RequestAppVersionInfoErrorBlock     requestErrorBlock;
@property (nonatomic, copy) RequestAppVersionInfoDidFinishBlock requestFinishBlock;

/**
 *	@brief	APP是否安装后第一次启动
 *
 *	@return	YES：第一次启动
 *
 *	Created by Mark on 2016-12-15 13:01
 */
+ (BOOL)isFirstLaunch;
+ (BOOL)resetFirstLaunch;

+ (NSString *)appName;
+ (NSString *)currentAppVersion;
+ (NSString *)currentBuildVersion;

#pragma mark -

+ (MKSAppInfo *)sharedManager;

/**
 *	@brief  获取AppStore上的App版本信息(需在.m文件配置的AppID信息，开发者你懂的!), 外部信息回传用Block(Error,Finish)
            App在AppStore上的APP_ID(例#define SkyComponentsAppID), 命名为SkyComponentsAppID
            获取方式为App于AppStore的Link, 如：
            https://itunes.apple.com/cn/app/accela-inspector/id492840294?l=en&mt=8,
            后id后的数字(492840294)
 *
 *  @param  appID           AppID
 *	@param 	aErrorBlock 	错误处理的Block代码段
 *	@param 	aFinishBlock 	完成处理的Block代码段
 *
 *	@return	N/A
 *
 *	Created by Mark on 2014-10-11 09:04
 */
- (void)requestAppVersionInfoInAppStoreWithAppID:(NSString *)appID
                                  withErrorBlock:(RequestAppVersionInfoErrorBlock)aErrorBlock
                                 withFinishBlock:(RequestAppVersionInfoDidFinishBlock)aFinishBlock;

@end
