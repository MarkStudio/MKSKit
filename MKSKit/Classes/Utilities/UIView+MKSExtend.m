//
//  UIView+MKExtend.m
//  Pods
//
//  Created by Mark Yang on 12/4/15.
//
//

#import "UIView+MKSExtend.h"

#pragma mark - UIView Frame

@implementation UIView (MKSFrame)

- (void)setMksX:(CGFloat)xValue
{
    CGRect frame = self.frame;
    frame.origin.x = xValue;
    self.frame = frame;
}//

- (CGFloat)mksX
{
    return self.frame.origin.x;
}//

- (void)setMksY:(CGFloat)yValue
{
    CGRect frame = self.frame;
    frame.origin.y = yValue;
    self.frame = frame;
}//

- (CGFloat)mksY
{
    return self.frame.origin.y;
}//

- (void)setMksWidth:(CGFloat)widthValue
{
    CGRect frame = self.frame;
    frame.size.width = widthValue;
    self.frame = frame;
}//

- (CGFloat)mksWidth
{
    return self.frame.size.width;
}//

- (void)setMksHeight:(CGFloat)heightValue
{
    CGRect frame = self.frame;
    frame.size.height = heightValue;
    self.frame = frame;
}//

- (CGFloat)mksHeight
{
    return self.frame.size.height;
}//

- (void)setMksMaxX:(CGFloat)MaxX
{
    CGRect frame = self.frame;
    frame.origin.x = ceilf(MaxX-frame.size.width);
    self.frame = frame;
}//

- (CGFloat)mksMaxX
{
    return self.frame.origin.x + self.frame.size.width;
}//

- (void)setMksMaxY:(CGFloat)MaxY
{
    CGRect frame = self.frame;
    frame.origin.y = ceilf(MaxY-frame.size.height);
    self.frame = frame;
}//

- (CGFloat)mksMaxY
{
    return self.frame.origin.y + self.frame.size.height;
}//

- (void)setMksCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}//

- (void)setMksCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}//

- (CGFloat)mksCenterX
{
    return self.center.x;
}//

- (CGFloat)mksCenterY
{
    return self.center.y;
}//

- (CGFloat)mksBoundWidth
{
    return self.bounds.size.width;
}//

- (CGFloat)mksBoundHeight
{
    return self.bounds.size.height;
}

@end

#pragma mark - UIView Extend

@implementation UIView (MKSExtend)

- (UIView *)showTips:(NSString *)strTips
{
    if (strTips.length < 1) {
        return nil;
    }
    
    UIFont *font = [UIFont systemFontOfSize:13.0];
    CGFloat kLeftPadding = 15.0;
//    CGSize aSize = [strTips sizeWithFont:font
//                       constrainedToSize:CGSizeMake(CGRectGetWidth(self.bounds)-kLeftPadding*2,
//                                                    MAXFLOAT)
//                           lineBreakMode:NSLineBreakByWordWrapping];
    CGRect aRect = [strTips boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds)-kLeftPadding*2, MAXFLOAT)
                                         options:(NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin)
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    CGSize aSize = aRect.size;
    UILabel *lbTips = [[UILabel alloc] initWithFrame:CGRectMake(kLeftPadding,
                                                                0,
                                                                aSize.width,
                                                                aSize.height)];
    [lbTips setFont:font];
    [lbTips setTextColor:[UIColor grayColor]];
    [lbTips setText:strTips];
    [lbTips setBackgroundColor:[UIColor clearColor]];
    [lbTips setCenter:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)-20)];
    [self addSubview:lbTips];
    
    return lbTips;
}//

- (void)removeAllSubViews
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    return ;
}//

@end
