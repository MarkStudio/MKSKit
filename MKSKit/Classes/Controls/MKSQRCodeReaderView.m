//
//  MKSQRCodeReaderView.m
//  Pods
//
//  Created by Mark Yang on 15/12/2016.
//
//

#import "MKSQRCodeReaderView.h"

@interface MKSQRCodeReaderView ()

@property (nonatomic, strong) CAShapeLayer *overLay;

@end

#pragma mark -

@implementation MKSQRCodeReaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addOverLay];
    }
    
    return self;
}//

#pragma mark -
#pragma mark Private Methods

- (void)addOverLay
{
    _overLay = [[CAShapeLayer alloc] init];
    _overLay.backgroundColor = [UIColor clearColor].CGColor;
    _overLay.fillColor       = [UIColor clearColor].CGColor;
    _overLay.strokeColor     = [UIColor whiteColor].CGColor;
    _overLay.lineWidth       = 3;
    _overLay.lineDashPattern = @[@7.0, @7.0];
    _overLay.lineDashPhase   = 0;
    
    [self.layer addSublayer:_overLay];
}//

@end
