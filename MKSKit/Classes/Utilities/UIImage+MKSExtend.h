//
//  UIImage+MKSExtend.h
//  Pods
//
//  Created by Mark Yang on 12/4/15.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (MKSExtend)

/**
 *	@brief	取得MKSKit下的图片资源(must: iOS 8.0+)
 *
 *	@param 	imgName 	图片名称
 *
 *	@return	UIImage instance
 *
 *	Created by Mark on 2016-12-14 21:11
 */
+ (UIImage *)mksBundleImageNamed:(NSString *)imgName;

/**
 *	@brief	根据颜色值生成图片(w*h=1*1)
 *
 *	@param 	color 颜色值
 *
 *	@return	生成的图片
 *
 *	Created by Mark on 2015-12-04 13:57
 */
+ (UIImage *)mksImageWithColor:(UIColor *)color;

/**
 *	@brief	生成指定颜色的圆角矩形图片
 *
 *	@param 	color 	颜色值
 *	@param 	size 	size
 *	@param 	raduis 	圆角值
 *
 *	@return	生成的图片
 *
 *	Created by Mark on 2015-12-04 13:54
 */
+ (UIImage *)mksImageWithColor:(UIColor *)color
                      withSize:(CGSize)size
              withCornerRadius:(CGFloat)raduis;

/**
 *	@brief	毛玻璃模糊转换
 *
 *	@param 	image 	原始图片
 *	@param 	blur 	模糊比例
 *
 *	@return	转换后的模糊图片
 *
 *	Created by Mark on 2015-12-07 10:58
 */
+ (UIImage *)mksBlurImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

#pragma mark -

// 之前为了做那个合成衣服的应用作的实验
+ (UIImage *)mksImageBlackToTransparent:(UIImage *)image;

@end
