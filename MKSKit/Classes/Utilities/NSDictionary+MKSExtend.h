//
//  NSDictionary+MKSExtend.h
//  Pods
//
//  Created by Mark Yang on 20/12/2016.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MKSExtend)

/**
 *	@brief  解决URL query字串为dictionay
 *
 *	@param 	query 	URL query string
 *	@param 	encoding 	NSStringEncoding
 *
 *	@return dictionary convert from URL query string
 *
 *	Created by Mark on 2016-12-20 20:54
 */
+ (NSDictionary *)mksDictionaryFromQuery:(NSString *)query encoding:(NSStringEncoding)encoding;

@end
