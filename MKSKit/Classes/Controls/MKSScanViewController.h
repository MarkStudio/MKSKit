//
//  MKSScanViewController.h
//  Pods
//
//  Created by Mark Yang on 15/12/2016.
//
//

#import <UIKit/UIKit.h>

@class MKSScanViewController;
@class MKSQRCodeReader;

NS_ASSUME_NONNULL_BEGIN

@protocol MKSScanViewControllerDelegate <NSObject>

@optional
- (void)reader:(MKSScanViewController *)codeController didScanResult:(NSString *)result;
- (void)readerDidCancel:(MKSScanViewController *)codeController;

@end

#pragma mark -

@interface MKSScanViewController : UIViewController

@property (nonatomic, weak) id<MKSScanViewControllerDelegate>   delegate;
@property (nonatomic, strong, readonly) MKSQRCodeReader         *codeReader;

#pragma mark -

/**
 *	@brief	默认的QR扫描ViewController
 *
 *	@return ScanViewController instance for QR
 *
 *	Created by Mark on 2016-12-15 17:16
 */
+ (instancetype)defaultQRScanController;

#pragma mark -

- (instancetype)initWithCancelButtonTitle:(nullable NSString *)cancelTitle
                               codeReader:(nonnull MKSQRCodeReader *)codeReader
                      startScanningAtLoad:(BOOL)startScanningAtLoad
                   showSwitchCameraButton:(BOOL)showSwitchCameraButton
                          showTorchButton:(BOOL)showTorchButton;

- (void)setCompletionBlock:(void (^)(NSString * _Nullable))completionBlock;
- (void)setupUIComponentsWithCancelButtonTitle:(NSString *)cancelButtonTitle;
- (void)btnCancelEvent:(id)sender;
- (void)toggleTorch:(id)sender;
- (void)startScanning;
- (void)stopScanning;

// override此方法自定义自己的操作页面
- (void)loadOperationView;

@end

NS_ASSUME_NONNULL_END
