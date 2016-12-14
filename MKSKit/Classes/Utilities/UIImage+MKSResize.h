//
//  UIImage+MKSResize.h
//  Pods
//
//  Created by Mark Yang on 12/7/15.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (MKSResize)

/**
 *	@brief	缩放图片至目标尺寸
 *
 *	@param 	待缩放的目标尺寸
 *
 *	@return 缩放后的图片
 *
 *	Created by Mark on 2015-08-06 09:53
 */
- (UIImage *)mksResizedImageToSize:(CGSize)dstSize;

/**
 *	@brief  Resize image fit in destination size scope
 *
 *	@param 	boundingSize 	Destination scope size (Width * Height)
 *	@param 	scale 	Need scale when size smaller
 *
 *	@return	New size image with fitted in
 *
 *	Created by Mark on 2015-08-06 09:53
 */
- (UIImage *)mksResizedImageToFitInSize:(CGSize)boundingSize
                         scaleIfSmaller:(BOOL)scale;

@end
