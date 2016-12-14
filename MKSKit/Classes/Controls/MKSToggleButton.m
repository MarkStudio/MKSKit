
//
//  MKSToggleButton.m
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#import "MKSToggleButton.h"

@interface MKSToggleButton ()

@property (nonatomic, strong) UIImage *onImage;
@property (nonatomic, strong) UIImage *offImage;

@end

#pragma mark -

@implementation MKSToggleButton

+ (id)buttonWithOnImage:(UIImage *)onImage
               offImage:(UIImage *)offImage
       highlightedImage:(UIImage *)highlightedImage
{
    MKSToggleButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.onImage = onImage;
    button.offImage = offImage;
    // default status is off()
    [button setBackgroundImage:offImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    button.autoToggleEnabled= YES;
    
    return button;
}//

- (void)setOn:(BOOL)onValue
{
    if (_on != onValue) {
        _on = onValue;
        [self setBackgroundImage:(_on ? _onImage : _offImage) forState:UIControlStateNormal];
    }
}//

#pragma mark - Toggle Support

- (BOOL)toggle
{
    [self setOn:!self.on];
    return self.on;
}//

#pragma mark -

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    if (self.touchInside && self.autoToggleEnabled) {
        [self toggle];
    }
}//

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
