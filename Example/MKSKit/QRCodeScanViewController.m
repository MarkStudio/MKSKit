//
//  QRCodeScanViewController.m
//  MissionskyOA
//
//  Created by Mark Yang on 1/5/16.
//  Copyright © 2016 Missionsky. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>

#define SHADOW_COLOR      [UIColor colorWithWhite:0.0 alpha:0.3]

static CGFloat kTopMargin = 28.0;
static CGFloat kTopInterval = 170.0;
static CGFloat kLeftPadding = 15.0;
static CGFloat kRightPadding = 15.0;

@interface QRCodeScanViewController ()

@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnLight;

@property (nonatomic, strong) UIImageView   *scanScopeView;
@property (nonatomic, strong) UIView        *topShadowView;
@property (nonatomic, strong) UIView        *leftShadowView;
@property (nonatomic, strong) UIView        *bottomShadowView;
@property (nonatomic, strong) UIView        *rightShadowView;
@property (nonatomic, strong) UILabel       *lbDecoded;
@property (nonatomic, strong) UIView        *scanLine;

@end

#pragma mark -

@implementation QRCodeScanViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidBecomeActiveNotification
                                                  object:nil];
}//

- (instancetype)initWithCancelButtonTitle:(NSString *)cancelTitle
                               codeReader:(MKSQRCodeReader *)codeReader
                      startScanningAtLoad:(BOOL)startScanningAtLoad
                   showSwitchCameraButton:(BOOL)showSwitchCameraButton
                          showTorchButton:(BOOL)showTorchButton
{
    self = [super initWithCancelButtonTitle:cancelTitle
                                 codeReader:codeReader
                        startScanningAtLoad:startScanningAtLoad
                     showSwitchCameraButton:showSwitchCameraButton
                            showTorchButton:showTorchButton];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActiveHandle:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    
    return self;
}//

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.codeReader setInterstRect:_scanScopeView.frame];
}//

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startScanLine];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}//

- (void)stopScanning
{
    [super stopScanning];
    [self stopScanLine];
}//

- (void)startScanning
{
    [super startScanning];
    [self startScanLine];
}//

#pragma mark -

- (void)loadOperationView
{
    _btnCancel = [[UIButton alloc] initWithFrame:CGRectZero];
    UIImage *imgBackNor = [UIImage imageNamed:@"code_back_normal"];
    [_btnCancel setImage:imgBackNor forState:UIControlStateNormal];
    [_btnCancel setShowsTouchWhenHighlighted:YES];
    [_btnCancel addTarget:self
                   action:@selector(btnCancelEvent:)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnCancel];
    [self.view bringSubviewToFront:_btnCancel];
//    [_btnCancel makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.top).offset(kTopMargin);
//        make.left.equalTo(self.view.left).offset(8);
//        make.width.equalTo(@44);
//        make.height.equalTo(@44);
//    }];
    
    _btnLight = [[UIButton alloc] initWithFrame:CGRectZero];
    UIImage *imgLightNor = [UIImage imageNamed:@"code_flash_normal"];
    [_btnLight setImage:imgLightNor forState:UIControlStateNormal];
    [_btnLight setShowsTouchWhenHighlighted:YES];
    [_btnLight addTarget:self
                  action:@selector(toggleTorch:)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnLight];
//    [_btnLight makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.top).offset(kTopMargin);
//        make.right.equalTo(self.view.right).offset(-8);
//        make.width.equalTo(@44);
//        make.height.equalTo(@44);
//    }];
}//

- (void)loadBackgroundLayer
{
    CGRect frameCapture = SCREEN_BOUNDS;
    CGFloat topInterval = kTopInterval;
//    CGFloat horizontalInterval = kHorizontalInterval;
    CGFloat captureWidth = frameCapture.size.width;
    CGFloat captureHeight = frameCapture.size.height;
//    CGFloat scannerWidth = frameCapture.size.width - (2 * horizontalInterval);
//    CGFloat scannerHeight = scannerWidth;
    
    UIImage *imgScanBK = [UIImage imageNamed:@"code_box"];
    _scanScopeView = [[UIImageView alloc] initWithFrame:CGRectMake(kLeftPadding,
                                                                   topInterval,
                                                                   frameCapture.size.width-kLeftPadding*2,
                                                                   imgScanBK.size.height)];
    [_scanScopeView setImage:imgScanBK];
    [self.view addSubview:_scanScopeView];
    
    _topShadowView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              captureWidth,
                                                              topInterval)];
    [_topShadowView setBackgroundColor:SHADOW_COLOR];
    [self.view addSubview:_topShadowView];
    
    _leftShadowView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                               topInterval,
                                                               kLeftPadding,
                                                               _scanScopeView.mksBoundHeight)];
    [_leftShadowView setBackgroundColor:SHADOW_COLOR];
    [self.view addSubview:_leftShadowView];
    
    _bottomShadowView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                 topInterval + _scanScopeView.mksBoundHeight,
                                                                 captureWidth,
                                                                 captureHeight - _scanScopeView.mksBoundHeight - topInterval)];
    [_bottomShadowView setBackgroundColor:SHADOW_COLOR];
    [self.view addSubview:_bottomShadowView];
    
    _rightShadowView = [[UIView alloc] initWithFrame:CGRectMake(captureWidth - kLeftPadding,
                                                                topInterval,
                                                                kRightPadding,
                                                                _scanScopeView.mksBoundHeight)];
    [_rightShadowView setBackgroundColor:SHADOW_COLOR];
    [self.view addSubview:_rightShadowView];
    
    //扫描框下面的提示
    _lbDecoded = [[UILabel alloc] initWithFrame:CGRectMake(20,
                                                           topInterval + _scanScopeView.mksBoundHeight + 30,
                                                           captureWidth - 40,
                                                           13)];
    [_lbDecoded setBackgroundColor:[UIColor clearColor]];
    [_lbDecoded setTextAlignment:NSTextAlignmentCenter];
    [_lbDecoded setTextColor:[UIColor whiteColor]];
    [_lbDecoded setFont:[UIFont systemFontOfSize:12]];
    [_lbDecoded setText:@"将二维码/条码放入框内，即可自动扫描"];
    [self.view addSubview:_lbDecoded];
    
    //扫描框里面的线
    _scanLine = [[UIView alloc] initWithFrame:CGRectZero];
    UIImage *imgScanLine = [UIImage imageNamed:@"code_line"];
    [_scanLine setFrame:CGRectMake(kLeftPadding,
                                   topInterval,
                                   _scanScopeView.mksBoundWidth,
                                   imgScanLine.size.height)];
    UIImageView *imgViewScanLine = [[UIImageView alloc] initWithFrame:_scanLine.bounds];
    [imgViewScanLine setImage:imgScanLine];
    [_scanLine addSubview:imgViewScanLine];
    [_scanLine setBackgroundColor:[UIColor clearColor]];
    [_scanLine setHidden:YES];
    [self.view addSubview:_scanLine];
}//

- (void)startScanLine
{
    [_scanLine.layer removeAllAnimations];
    [_scanLine setMksY:kTopInterval];
    [_scanLine setHidden:NO];
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:3.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    [_scanLine setMksY:kTopInterval + _scanScopeView.mksBoundHeight];
    [UIView commitAnimations];
}//

- (void)stopScanLine
{
    [_scanLine setHidden:YES];
    [_scanLine setMksY:kTopInterval];
    [_scanLine.layer removeAllAnimations];
}//

- (void)applicationDidBecomeActiveHandle:(NSNotification *)noti
{
    [self startScanLine];
}//

// do not invoke this method manually, just add your custom UI within scan view.
- (void)setupUIComponentsWithCancelButtonTitle:(NSString *)cancelButtonTitle
{
    [super setupUIComponentsWithCancelButtonTitle:cancelButtonTitle];
//    [self loadBackgroundLayer];
    [self loadOperationView];
}//

@end
