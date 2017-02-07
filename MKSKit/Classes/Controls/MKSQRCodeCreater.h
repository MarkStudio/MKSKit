//
//  MKSQRCodeCreater.h
//  Pods
//
//  Created by Mark Yang on 15/12/2016.
//
//

#import <Foundation/Foundation.h>

@interface MKSQRCodeCreater : NSObject

/**
 *	@brief  生成相应字串的QRCode图片
 *
 *	@param 	strInfo 	QRCode info string
 *
 *	@return	UIImage instance (default size : 100 * 100)
 *
 *	Created by Mark on 2016-12-15 15:24
 */
+ (UIImage *)createQRCodeImageWithInfo:(NSString *)strInfo;

+ (UIImage *)createQRCodeImageWithInfo:(NSString *)strInfo sideLength:(CGFloat)sideWidth;

@end
