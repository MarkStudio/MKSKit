//
//  MKSToggleButton.h
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#import <UIKit/UIKit.h>

@interface MKSToggleButton : UIButton

@property (nonatomic, getter=isOn) BOOL on;

/**
 *	@brief	点击按钮后自动更新UI状态, default is YES,
 *          否则自己调用在按钮方法中调用 toggle 方法
 *
 *	Created by Mark on 2016-12-14 15:55
 */
@property (nonatomic, getter=isAutoToggleEnabled) BOOL autoToggleEnabled;

#pragma mark -

+ (id)buttonWithOnImage:(UIImage *)onImage
               offImage:(UIImage *)offImage
       highlightedImage:(UIImage *)highlightedImage;

#pragma mark -

/**
 *	@brief	change the selected state, UIButton will update appearance automatically
 *
 *	@return	current toggle state
 *
 *	Created by Mark on 2016-12-14 15:42
 */
- (BOOL)toggle;

@end
