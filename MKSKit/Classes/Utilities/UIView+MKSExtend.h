//
//  UIView+MKExtend.h
//  Pods
//
//  Created by Mark Yang on 12/4/15.
//
//

#import <UIKit/UIKit.h>

#pragma mark - UIView Frame

@interface UIView (MKSFrame)

@property (nonatomic, assign) CGFloat mksX;
@property (nonatomic, assign) CGFloat mksY;
@property (nonatomic, assign) CGFloat mksWidth;
@property (nonatomic, assign) CGFloat mksHeight;
@property (nonatomic, assign) CGFloat mksMaxX;
@property (nonatomic, assign) CGFloat mksMaxY;
@property (nonatomic, assign) CGFloat mksCenterX;
@property (nonatomic, assign) CGFloat mksCenterY;
@property (nonatomic, assign, readonly) CGFloat mksBoundWidth;
@property (nonatomic, assign, readonly) CGFloat mksBoundHeight;

@end

#pragma mark - UIView Extend

@interface UIView (MKSExtend)

/**
 *	@brief	Show Toast Tip View with Tip String
 *
 *	@param 	strTips 	Tip String
 *
 *	@return	Toast View
 *
 *	Created by Mark on 2015-12-07 10:26
 */
- (UIView *)showTips:(NSString *)strTips;

/**
 *	@brief	Remove all subviews
 *
 *	@return	N/A
 *
 *	Created by Mark on 2015-12-04 15:51
 */
- (void)removeAllSubViews;

@end
