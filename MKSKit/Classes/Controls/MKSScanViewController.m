//
//  MKSScanViewController.m
//  Pods
//
//  Created by Mark Yang on 15/12/2016.
//
//

#import "MKSScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MKSQRCodeReader.h"
#import "MKSQRCodeReaderView.h"
#import "MKSSystemCon.h"

@interface MKSScanViewController ()

@property (nonatomic, strong) MKSQRCodeReader      *codeReader;
@property (nonatomic, strong) MKSQRCodeReaderView   *cameraView;
@property (nonatomic, assign) BOOL                 startScanningAtLoad;
@property (nonatomic, assign) BOOL                 showSwitchCameraButton;
@property (nonatomic, assign) BOOL                 showTorchButton;

@property (nonatomic, copy) void (^completionBlock) (NSString * __nullable);

@end

#pragma mark -

@implementation MKSScanViewController

#pragma mark - Accessory

- (void)setCompletionBlock:(void (^)(NSString * _Nullable))completionBlock
{
    _completionBlock = completionBlock;
}//

#pragma mark  - Initialize

- (void)dealloc
{
    [NCC removeObserver:self
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
}//

- (id)init
{
    return [self initWithCancelButtonTitle:nil];
}//

- (id)initWithCancelButtonTitle:(NSString *)strCancelTitle
{
    return [self initWithCancelButtonTitle:strCancelTitle
                       metadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
}//

- (id)initWithMetadataObjectTypes:(NSArray *)metadataObjectTypes
{
    return [self initWithCancelButtonTitle:nil metadataObjectTypes:metadataObjectTypes];
}

- (id)initWithCancelButtonTitle:(NSString *)cancelTitle metadataObjectTypes:(NSArray *)metadataObjectTypes
{
    MKSQRCodeReader *reader = [MKSQRCodeReader readerWithMetadataObjectTypes:metadataObjectTypes];
    return [self initWithCancelButtonTitle:cancelTitle codeReader:reader];
}

- (id)initWithCancelButtonTitle:(NSString *)cancelTitle codeReader:(MKSQRCodeReader *)codeReader
{
    return [self initWithCancelButtonTitle:cancelTitle codeReader:codeReader startScanningAtLoad:true];
}

- (id)initWithCancelButtonTitle:(NSString *)cancelTitle
                     codeReader:(MKSQRCodeReader *)codeReader
            startScanningAtLoad:(BOOL)startScanningAtLoad
{
    return [self initWithCancelButtonTitle:cancelTitle
                                codeReader:codeReader
                       startScanningAtLoad:startScanningAtLoad
                    showSwitchCameraButton:YES
                           showTorchButton:NO];
}

- (instancetype)initWithCancelButtonTitle:(nullable NSString *)cancelTitle
                               codeReader:(nonnull MKSQRCodeReader *)codeReader
                      startScanningAtLoad:(BOOL)startScanningAtLoad
                   showSwitchCameraButton:(BOOL)showSwitchCameraButton
                          showTorchButton:(BOOL)showTorchButton
{
    self = [super init];
    if (self) {
        self.view.backgroundColor   = [UIColor grayColor];
        self.codeReader             = codeReader;
        self.startScanningAtLoad    = startScanningAtLoad;
        self.showSwitchCameraButton = showSwitchCameraButton;
        self.showTorchButton        = showTorchButton;

        if (cancelTitle == nil) {
            cancelTitle = NSLocalizedString(@"Cancel", @"Cancel");
        }

        [self setupUIComponentsWithCancelButtonTitle:cancelTitle];
        [self setupAutoLayoutConstraints];

        [_cameraView.layer insertSublayer:_codeReader.previewLayer atIndex:0];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];

        __weak typeof(self) weakSelf = self;
        [codeReader setCompletionWithBlock:^(NSString *resultAsString) {
            if (weakSelf.completionBlock != nil) {
                weakSelf.completionBlock(resultAsString);
            }
            if (weakSelf.delegate &&
                [weakSelf.delegate respondsToSelector:@selector(reader:didScanResult:)]) {
                [weakSelf.delegate reader:weakSelf didScanResult:resultAsString];
            }
        }];
        
        [NCC addObserver:self
                selector:@selector(applicationDidBecomeActiveHandle:)
                    name:UIApplicationDidBecomeActiveNotification
                  object:nil];
    }
    
    return self;
}

#pragma mark -

+ (instancetype)defaultQRScanController
{
//    NSArray *arrMetaObjectTypes = @[AVMetadataObjectTypeQRCode,                // 二维码
//                                    AVMetadataObjectTypeEAN13Code,             // 条形码
//                                    AVMetadataObjectTypeEAN8Code,
//                                    AVMetadataObjectTypeCode39Code,
//                                    AVMetadataObjectTypeCode39Mod43Code,
//                                    AVMetadataObjectTypeCode128Code];
    NSArray *arrMetaObjectTypes = @[AVMetadataObjectTypeQRCode];
    if ([MKSQRCodeReader supportsMetadataObjectTypes:arrMetaObjectTypes]) {
        MKSQRCodeReader *reader = [MKSQRCodeReader readerWithMetadataObjectTypes:arrMetaObjectTypes];
        MKSScanViewController *vc = nil;
        vc = [[MKSScanViewController alloc] initWithCancelButtonTitle:@"取消"
                                                           codeReader:reader
                                                  startScanningAtLoad:YES
                                               showSwitchCameraButton:YES
                                                      showTorchButton:YES];
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        
        return vc;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Reader not supported by the current device"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    return nil;
}//

#pragma mark -

- (void)setupUIComponentsWithCancelButtonTitle:(NSString *)cancelButtonTitle
{
    _cameraView = [[MKSQRCodeReaderView alloc] init];
    _cameraView.translatesAutoresizingMaskIntoConstraints = NO;
    _cameraView.clipsToBounds = YES;
    [self.view addSubview:_cameraView];
    
    [_codeReader.previewLayer setFrame:CGRectMake(0,
                                                  0,
                                                  self.view.frame.size.width,
                                                  self.view.frame.size.height)];
    
    if ([_codeReader.previewLayer.connection isVideoOrientationSupported]) {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        _codeReader.previewLayer.connection.videoOrientation = [MKSQRCodeReader videoOrientationFromInterfaceOrientation:orientation];
    }
    
    //    if (_showSwitchCameraButton && [_codeReader hasFrontDevice]) {
    //        _switchCameraButton = [[QRCameraSwitchButton alloc] init];
    //
    //        [_switchCameraButton setTranslatesAutoresizingMaskIntoConstraints:false];
    //        [_switchCameraButton addTarget:self action:@selector(switchCameraAction:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.view addSubview:_switchCameraButton];
    //    }
    
    //    if (_showTorchButton && [_codeReader isTorchAvailable]) {
    //        _toggleTorchButton = [[QRToggleTorchButton alloc] init];
    //
    //        [_toggleTorchButton setTranslatesAutoresizingMaskIntoConstraints:false];
    //        [_toggleTorchButton addTarget:self action:@selector(toggleTorchAction:) forControlEvents:UIControlEventTouchUpInside];
    //        [self.view addSubview:_toggleTorchButton];
    //    }
    
    //    _btnCancel = [[UIButton alloc] init];
    //    [_btnCancel setFrame:CGRectMake(0, 0, 100, 30)];
    //    _btnCancel.translatesAutoresizingMaskIntoConstraints = NO;
    //    [_btnCancel setBackgroundColor:[UIColor redColor]];
    //    [_btnCancel setTitle:cancelButtonTitle forState:UIControlStateNormal];
    //    [_btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    //    [_btnCancel addTarget:self
    //                   action:@selector(btnCancelEvent:)
    //         forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:_btnCancel];
}

- (void)loadOperationView
{
    [self loadDefaultBackgroundLayer];
}//

- (void)loadDefaultBackgroundLayer
{
#warning ME
}//

- (void)setupAutoLayoutConstraints
{
    NSDictionary *views = NSDictionaryOfVariableBindings(_cameraView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cameraView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cameraView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
}//

- (void)orientationChanged:(NSNotification *)notification
{
    [_cameraView setNeedsDisplay];
    if (_codeReader.previewLayer.connection.isVideoOrientationSupported) {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        _codeReader.previewLayer.connection.videoOrientation = [MKSQRCodeReader videoOrientationFromInterfaceOrientation:orientation];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [aView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:aView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_startScanningAtLoad) {
        [self startScanning];
    }
}//

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopScanning];
    [super viewWillDisappear:animated];
}//

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _codeReader.previewLayer.frame = self.view.bounds;
}//

- (BOOL)shouldAutorotate
{
    return YES;
}//

- (void)btnCancelEvent:(id)sender
{
    [_codeReader stopScanning];
    if (_completionBlock) {
        _completionBlock(nil);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(readerDidCancel:)]) {
        [_delegate readerDidCancel:self];
    }
}//

- (void)startScanning
{
    [_codeReader startScanning];
}//

- (void)stopScanning
{
    [_codeReader stopScanning];
}//

- (void)switchDeviceInput
{
    [_codeReader switchDeviceInput];
}//

- (void)toggleTorch:(id)sender
{
    [_codeReader toggleTorch];
}//


@end
