//
//  MKSQRCodeReader.h
//  Pods
//
//  Created by Mark Yang on 15/12/2016.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MKSQRCodeReader : NSObject

@property (nonatomic, strong, readonly) NSArray                     *metadataObjectTypes;
@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer  *previewLayer;

#pragma mark -

+ (BOOL)supportsMetadataObjectTypes:(NSArray *)metadataObjectTypes;
+ (AVCaptureVideoOrientation)videoOrientationFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

#pragma mark -

+ (instancetype)readerWithMetadataObjectTypes:(NSArray *)metadataObjectTypes;

- (void)setCompletionWithBlock:(void (^) (NSString *resultAsString))completionBlock;

- (BOOL)hasFrontDevice;         // 前置摄像头
- (BOOL)isTorchAvailable;       // 前置电筒

#pragma mark -
#pragma mark Control Reader

- (void)startScanning;
- (void)stopScanning;
- (BOOL)isRunning;
- (void)switchDeviceInput;
- (void)toggleTorch;

/**
 *	@brief	设置扫描区域(基于Screen Size)
 *
 *	@param 	interestRect 	扫描区域的屏幕坐标
 *
 *	@return	N/A
 *
 *	Created by Mark on 2015-11-20 14:22
 */
- (void)setInterstRect:(CGRect)interestRect;

@end
