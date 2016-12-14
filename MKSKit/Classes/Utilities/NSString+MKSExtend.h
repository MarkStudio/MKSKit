//
//  NSString+MKSExtend.h
//  Pods
//
//  Created by Mark Yang on 12/4/15.
//
//

#import <Foundation/Foundation.h>

@interface NSString (MKSExtend)

/**
 *	@brief	根据APNS Token转换成相应字符串
 *
 *	@param 	deviceTokenData
 *
 *	@return	APNS Token String
 *
 *	Created by Mark on 2015-12-04 16:52
 */
+ (NSString *)stringWithTokenData:(NSData *)deviceTokenData;

@end
